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
            let makeName = try getMakeName(context: &objectContext)
            print(makeName + "gg")
            fetchModelsRequest.predicate = NSPredicate(format: "make == %@", makeName)
            try models = objectContext.fetch(fetchModelsRequest) as [Vehicle2]
        }
        catch
        {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
        print(models.count)
    }
    
    private func getMakeName(context: inout NSManagedObjectContext) throws -> String
    {
        let userData = try context.fetch(fetchUserRequest)
        
        return (userData.first?.selectMake)!
    }
    
    // Return the number of objects in this Entity
    func getNumObjects() -> Int
    {
        return models.count
    }
    
    func getRowDescription(index: Int) -> String
    {
        return "a" //models[index].name!
    }
}
