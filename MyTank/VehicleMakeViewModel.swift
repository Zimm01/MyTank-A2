//
//  VehicleViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 6/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class VehicleMakeViewModel
{
    // Our persistant container from the CoreData Model
    private var persistentContainer = NSPersistentContainer(name: "Model")
    
    // Our Request to fetch the Make Model from Object Context
    private var makeFetchRequest : NSFetchRequest<VehicleMakes> = NSFetchRequest(entityName: "VehicleMakes")
    
    // Our Request to fetch the Make Model from Object Context
    private var userDataFetchRequest : NSFetchRequest<UserData2> = NSFetchRequest(entityName: "UserData2")
    
    // Our array of Vehicle Makes
    private var makes = [VehicleMakes]()
    
    private let firstUserObject = 1
    
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
        let objectContext = persistentContainer.viewContext
        
        do
        {
            try makes = objectContext.fetch(makeFetchRequest) as [VehicleMakes]
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
        
        return makes.count
    }
    
    // Get the name specified at the selected Index Path
    func getRowDescription(index: Int) -> String
    {
        return makes[index].name!
    }
    
    func commitSelectedMake(index: Int) -> Bool
    {
        // Our persistant container from the CoreData Model
        let objectContext = persistentContainer.viewContext
        
        //let userDataEntity = NSEntityDescription.entity(forEntityName: "UserData2", in: objectContext)
        
        do
        {
            let userDataObject = try objectContext.fetch(userDataFetchRequest)
            let makeDataObject = try objectContext.fetch(makeFetchRequest)
            
            if let userData = userDataObject.first
            {
                print(makeDataObject[index].name!)
                userData.setValue(makeDataObject[index].name, forKey: "selectMake")
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
