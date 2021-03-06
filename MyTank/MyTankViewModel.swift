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
    internal var userDataFetchReq : NSFetchRequest<UserData> = NSFetchRequest(entityName: "UserData")

    // Our Request to fetch the Models from Object Context
    internal var vehicleFetchReq : NSFetchRequest<Vehicle> = NSFetchRequest(entityName: "Vehicle")
    
    // Our selected vehicles DB index
    internal var vehicleSelected:Int32
    
    // Initialize the class, load the persistant store!
    init()
    {
        // Load our persistent container from coreData
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
            }
        }
        
        // Set our vehicle selected index to the "invalid" property
        vehicleSelected = MyTankConstants.invalidID
    }
    
    // Check to see if a vehicle in the database
    func userHasVehicle() -> Bool
    {
        // Our persistant container from the CoreData Model
        let objectContext = persistentContainer.viewContext
        
        do
        {
            let userDataObject = try objectContext.fetch(userDataFetchReq)
            
            // We will attempt to find a valid vehicle ID in the database
            if let userData = userDataObject.first
            {
                vehicleSelected = userData.vehicleID
                
                if vehicleSelected != MyTankConstants.invalidID
                {
                    return true
                }
            }
        }
        catch{
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
        // If no vehicle is found we will return false
        return false
    }
    
    // Takes a list of vehicles and sorts them to be singular occurences, based on model name only
    internal func makeVehicleListSingletons(vehList: inout [Vehicle], sortBy: VehicleSortProperties)
    {
        var newVehicleList = [Vehicle]()
        for thisVehicle in vehList
        {
            //Firstly, if this is our initial run, we will automatically add the first model
            if newVehicleList.count == 0
            {
                newVehicleList.append(thisVehicle)
                continue
            }
            else if (sortBy == VehicleSortProperties.model) && (newVehicleList.lazy.first(where: {$0.model == thisVehicle.model}) == nil)
            {
                newVehicleList.append(thisVehicle)
            }
            else if (sortBy == VehicleSortProperties.series) && (newVehicleList.lazy.first(where: {$0.series == thisVehicle.series}) == nil)
            {
                newVehicleList.append(thisVehicle)
            }
        }
    
        // This sort combines each property, so we can still sort by different properties of a 'Vehicle' and always have that peoperty in alphabetical order!
        newVehicleList.sort{($0.model! + $0.series!) < ($1.model! + $1.series!)}
        
        // We have successfully compiled a singular list of models, now we can overwite the 'models' array so that we have a simplifed list to hand to the view
        vehList = newVehicleList
    }
    
    // Returns the VEHICLE MAKE the User Has Selected at the Vehicle Selection Stage, but not yet committed to the database
    internal func getUncommitedMake(context: inout NSManagedObjectContext) throws -> String
    {
        let userData = try context.fetch(userDataFetchReq)
        return (userData.first?.selectMake)!
    }
    
    // Returns the VEHICLE MODEL name the User Has Selected at the Vehicle Selection Stage, but not yet committed to the database
    internal func getUncommitedModel(context: inout NSManagedObjectContext) throws -> String
    {
        let userData = try context.fetch(userDataFetchReq)
        return (userData.first?.selectModel)!
    }
    
    // This function takes a double value and returns it as a formatted currecny value, with 2 decimal places and a currency designator
    internal func formatAsCurrencyVal(inputValue: Float)->String
    {
        let totalAsString = String(format: "%.2f", inputValue)
        
        return MyTankConstants.currencyUnit + " " + totalAsString
    }
    
    // This function takes a double value and returns it as a formatted distance value
    internal func formatAsDistanceVal(inputValue: Int32)->String
    {
        let distanceAsString = String(inputValue) + MyTankConstants.defaultDistanceValue
        
        return distanceAsString
    }
}
