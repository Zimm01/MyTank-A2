//
//  VehicleModelViewData.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 12/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class VehicleModelViewModel
{
    // Our persistant container from the CoreData Model
    private var persistentContainer = NSPersistentContainer(name: "Model")
    
    // Our Request to fetch the Models from Object Context
    private var fetchModelsRequest : NSFetchRequest<Vehicle2> = NSFetchRequest(entityName: "Vehicle2")
    private var fetchUserRequest : NSFetchRequest<UserData2> = NSFetchRequest(entityName: "UserData2")
    
    // Our array of Vehicle Makes
    private var models = [Vehicle2]()
    
    private var makeName:String = ""
    
    // We want to load our persistant container and then place the values in an array to be used by displayed as in the view
    init()
    {
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
            }
            else
            {
                
            }
        }
        
        // Our persistant container from the CoreData Model
        var objectContext = persistentContainer.viewContext
        
        do
        {
            // Get the make name selected previously by the user
            self.makeName = try getMakeName(context: &objectContext)
    print(makeName + "gg")
            // This is where we perform the predicate fetch and assign the results to 'models'
            fetchModelsRequest.predicate = NSPredicate(format: "make == %@", makeName)
            try models = objectContext.fetch(fetchModelsRequest) as [Vehicle2]
        }
        catch
        {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
        // Our fetch was a great success, we now want to sort the models so that the list only
        // Displays individual models, rather than multiples of the same
        makeModelsSingular()
    }
    
    // Returns the make name that the user had selected at the 'Select Make' stage, held in CoreData
    private func getMakeName(context: inout NSManagedObjectContext) throws -> String
    {
        let userData = try context.fetch(fetchUserRequest)
        
        return (userData.first?.selectMake)!
    }
    
    // Takes a list of vehicles and sorts them to be singular occurences, based on model name only
    private func makeModelsSingular()
    {
        var newModels = [Vehicle2]()
        
        for thisVehicle in models
        {
            //Firstly, if this is our initial run, we will automatically add the first model
            if newModels.count == 0
            {
                newModels.append(thisVehicle)
                continue
            }
            else if (newModels.lazy.first(where: {$0.model == thisVehicle.model})) == nil
            {
                newModels.append(thisVehicle)
            }
        }

        newModels.sort{$0.model! < $1.model!}
        
        // We have successfully compiled a singular list of models, now we can overwite the 'models' array so that we have a simplifed list to hand to the view
        models = newModels
    }
    
    // Return the number of objects in this Entity
    func getNumObjects() -> Int
    {
        return models.count
    }
    
    // Return the model at each index point
    func getRowDescription(index: Int) -> String
    {
        return models[index].model!
    }
    
    // Return the body type, perform a check first to ensure the body type actually exists!
    func getBodyType(index: Int) -> String
    {
        var bodyType = models[index].type!
        
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
            let userDataObject = try objectContext.fetch(fetchUserRequest)
            //let makeDataObject = try objectContext.fetch(makeFetchRequest)
            
            if let userData = userDataObject.first
            {
                print(models[index].model!)
                userData.setValue(models[index].model, forKey: "selectModel")
            }
            else
            {
                throw NSError()
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
