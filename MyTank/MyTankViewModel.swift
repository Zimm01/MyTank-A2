//
//  MyTankViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 15/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

// Parent Class of All View Models in the MyTank Application
class MyTankViewModel
{
    // Our persistant container from the CoreData Model, to be used by all children for updating/fetching from the object contxt
    internal var persistentContainer = NSPersistentContainer(name: "Model")

    
    // Initialize the class, load the persistant store!
    init()
    {
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
}
