//
//  VehicleModelViewData.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 12/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class VehicleModelViewModel: MyTankViewModel
{
    // Our array of Vehicle Makes
    private var modelList = [Vehicle2]()
    
    private var makeName:String = ""
    
    // We want to place the values in an array to be used by displayed as in the view
    override init()
    {
        super.init()
        
        // Our persistant container from the CoreData Model
        var objectContext = persistentContainer.viewContext
        
        do
        {
            // Get the make name selected previously by the user
            self.makeName = try super.getUncommitedMake(context: &objectContext)

            // This is where we perform the predicate fetch and assign the results to 'models'
            vehicleFetchReq.predicate = NSPredicate(format: "make == %@", makeName)
            try modelList = objectContext.fetch(vehicleFetchReq) as [Vehicle2]
        }
        catch
        {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
        // Our fetch was a great success, we now want to sort the models so that the list only
        // Displays individual models, rather than multiples of the same
        super.makeVehicleListSingletons(vehList: &modelList, sortBy: VehicleSortProperties.model)
    }
    
    // Return the number of objects in this Entity
    func getNumObjects() -> Int
    {
        return modelList.count
    }
    
    // Return the model at each index point
    func getRowDescription(index: Int) -> String
    {
        return modelList[index].model!
    }
    
    // Return the body type, perform a check first to ensure the body type actually exists!
    func getBodyType(index: Int) -> String
    {
        var bodyType = modelList[index].type!
        
        // TODO: find a more eloquant way to express this!
        switch bodyType{
        case BodyTypes.smallCar.rawValue:
            break
        case BodyTypes.mediumCar.rawValue:
            break
        case BodyTypes.largeCar.rawValue:
            break
        case BodyTypes.suvCar.rawValue:
            break
        case BodyTypes.fwd.rawValue:
            break
        case BodyTypes.uteCar.rawValue:
            break
        case BodyTypes.van.rawValue:
            break
        case BodyTypes.truck.rawValue:
            break
        default:
            bodyType = BodyTypes.mediumCar.rawValue
        }
        
        return bodyType
    }
    
    func commitSelectedMake(index: Int) -> Bool
    {
        // Our persistant container from the CoreData Model
        let objectContext = persistentContainer.viewContext
        
        do
        {
            let userDataObject = try objectContext.fetch(userDataFetchReq)
            
            if let userData = userDataObject.first
            {
                print(modelList[index].model!)
                userData.setValue(modelList[index].model, forKey: "selectModel")
            }
            else
            {
                throw VehicleError.invalidVehicle
            }
            
            try objectContext.save()
        }
        catch
        {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
            return false
        }
        return true
    }

}
