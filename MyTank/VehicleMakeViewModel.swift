//
//  VehicleViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 6/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class VehicleMakeViewModel: MyTankViewModel
{    
    // Our Request to fetch the Make Model from Object Context
    private var makeFetchRequest : NSFetchRequest<VehicleMakes> = NSFetchRequest(entityName: "VehicleMakes")
    
    // Our array of Vehicle Makes
    private var makeList = [VehicleMakes]()
    
    private let firstUserObject = 1
    
    // We want to place the values in an array to be used by displayed as in the view
    override init()
    {
        super.init()
        
        // Our persistant container from the CoreData Model
        let objectContext = persistentContainer.viewContext
        
        do
        {
            try makeList = objectContext.fetch(makeFetchRequest) as [VehicleMakes]
            makeList.sort{$0.name! < $1.name!}
        }
        catch
        {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }

    // Return the number of objects in this Entity
    func getNumObjects() -> Int
    {
        
        return makeList.count
    }
    
    // Get the name specified at the selected Index Path
    func getRowDescription(index: Int) -> String
    {
        return makeList[index].name!
    }
    
    // Select the MAKE and commit it to the USERDATA object in COREDATA
    func commitSelectedMake(index: Int) -> Bool
    {
        // Our persistant container from the CoreData Model
        let objectContext = persistentContainer.viewContext
        
        do
        {
            let userDataObject = try objectContext.fetch(userDataFetchRequest)
            
            if let userData = userDataObject.first
            {
                print(makeList[index].name!)
                userData.setValue(makeList[index].name, forKey: "selectMake")
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
