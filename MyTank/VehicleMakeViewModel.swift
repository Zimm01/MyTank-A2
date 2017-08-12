//
//  VehicleViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 6/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import CoreData

class VehicleMakeViewModel : NSObject
{
    // Our persistant container from the CoreData Model
    private var persistentContainer = NSPersistentContainer(name: "Model")
    
    // Our Request to fetch the Make Model from Object Context
    private var fetchRequest : NSFetchRequest<VehicleMakes> = NSFetchRequest(entityName: "VehicleMakes")
    
    // Our array of Vehicle Makes
    private var makes = [VehicleMakes]()
    
    
    override init()
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
            try makes = objectContext.fetch(fetchRequest) as [VehicleMakes]
        }
        catch
        {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }

        print(makes.count)
    }

    
    func getNumObjects() -> Int
    {
        
        return makes.count
    }
    
    /*func getResultController() -> NSFetchedResultsController<Vehicle2>
    {
        //return vehicleResultsController
    }*/
}
