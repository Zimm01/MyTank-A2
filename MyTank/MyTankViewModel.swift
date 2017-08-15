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
    
    // Our Fetch Request for the 'UserData' CoreData Container
    internal var userDataFetchRequest : NSFetchRequest<UserData2> = NSFetchRequest(entityName: "UserData2")

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
    
    // Takes a list of vehicles and sorts them to be singular occurences, based on model name only
    // TODO fix the 'byModel' flag
    internal func makeVehicleListSingletons(vehList: inout [Vehicle2], byModel: Bool)
    {
        var newVehicleList = [Vehicle2]()
        for thisVehicle in vehList
        {
            //Firstly, if this is our initial run, we will automatically add the first model
            if newVehicleList.count == 0
            {
                newVehicleList.append(thisVehicle)
                continue
            }
            else if byModel && (newVehicleList.lazy.first(where: {$0.model == thisVehicle.model}) == nil)
            {
                newVehicleList.append(thisVehicle)
            }
            else if !byModel && (newVehicleList.lazy.first(where: {$0.variant == thisVehicle.variant}) == nil)
            {
                newVehicleList.append(thisVehicle)
            }
        }
    
        newVehicleList.sort{($0.model! + $0.variant!) < ($1.model! + $1.variant!)}
        
        // We have successfully compiled a singular list of models, now we can overwite the 'models' array so that we have a simplifed list to hand to the view
        vehList = newVehicleList
    }
    
    // Returns the VEHICLE MAKE the User Has Selected at the Vehicle Selection Stage, but not yet committed to the database
    internal func getUncommitedMake(context: inout NSManagedObjectContext) throws -> String
    {
        let userData = try context.fetch(userDataFetchRequest)
        return (userData.first?.selectMake)!
    }
    
    // Returns the VEHICLE MODEL name the User Has Selected at the Vehicle Selection Stage, but not yet committed to the database
    internal func getUncommitedModel(context: inout NSManagedObjectContext) throws -> String
    {
        let userData = try context.fetch(userDataFetchRequest)
        return (userData.first?.selectModel)!
    }
}
