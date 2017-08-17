//
//  VehicleCustomiserViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 14/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class CustomiseVehicleViewModel: MyTankViewModel
{
    private var vehicleSelected:Int32 = -1
 
    // Our Request to fetch a Vehicle from Object Context
    private var fetchVehicleRequest : NSFetchRequest<Vehicle2> = NSFetchRequest(entityName: "Vehicle2")
    
    // We want to place the values in an array to be used by displayed as in the view
    override init()
    {
        super.init()
    }
    
    // Commit Vehicle with a given series and Variant to the Database, by first perforing a 'reverse lookup' on the values, to confirm their existence and then commit that vehicles ID to the UserData Object
    func commitSeriesVairantToDB(tuple: (series: String, variant: String)) -> Bool
    {
        // Our persistant container from the CoreData Model
        var objectContext = persistentContainer.viewContext
        
        do{
            // First we will 'Reverse Lookup' our vehicle from the database, to ensure the vehicle exists
            if try performReverseLookup(context: &objectContext, tupleIn: tuple)
            {
                // Next we will load the userData object
                let userDataObject = try objectContext.fetch(userDataFetchRequest)
                if let userData = userDataObject.first
                {
                    // Attempt to set the vehicleID in user data for persistent reference
                    userData.setValue(vehicleSelected, forKey: "vehicleID")
                                    print(userData.vehicleID)
                }
                else{
                    throw VehicleError.invalidVehicle
                }
        
                try objectContext.save()
                return true
            }
        }
        catch
        {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }

        return false
    }
    
    // Perform a reverse lookup on the data selected by the user to ensure a Vehicle object exists with the selected parameters. Return true if so and set the vehicleSelected memebr to reflect
    private func performReverseLookup(context: inout NSManagedObjectContext, tupleIn: (series: String, variant: String)) throws -> Bool
    {
        // First load the make and model
        let thisMake = try super.getUncommitedMake(context: &context)
        let thisModel = try super.getUncommitedModel(context: &context)
        
        // Next, set up our predicate for the search
        fetchVehicleRequest.predicate = NSPredicate(format: "make == %@ AND model == %@ AND series == %@ AND variant == %@", thisMake, thisModel, tupleIn.series, tupleIn.variant)
        
        // Attempt to fetch the context, if the result contains ONLY ONE entry, it has worked correctly so we can commit that data to the userData object!
        let vehicleResult = try context.fetch(fetchVehicleRequest) as [Vehicle2]
        if vehicleResult.count == 1
        {
            let theVehicle = vehicleResult.first
            vehicleSelected = theVehicle!.id
            
            return true
        }

        return false
    }
    
}
