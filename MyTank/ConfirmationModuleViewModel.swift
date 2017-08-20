//
//  ConfirmationViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 19/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class ConfirmationModuleViewModel: MyTankViewModel
{
    override init()
    {
        super.init()
    }
    
    // Return the vehicle data as a tuple
    func getVehicleData() throws -> (vehicleStr: String, consumptionStr: String, costStr: String)
    {
        var specificVehicleString = ""
        var consumptionString = ""
        var costString = ""
        
        // Our persistant container from the CoreData Model, and our user object
        let objectContext = persistentContainer.viewContext
        let userDataObject = try objectContext.fetch(userDataFetchReq)
        
        // Get the user data so that we can access the vehicle ID
        if let userData = userDataObject.first
        {
            // Set the cost per unit of fuel
            costString = formatAsCurrencyVal(inputValue: userData.costPerUnit)
            
            let userVehicleID:Int32 = userData.vehicleID
            
            // Attempt to find the vehicle given by the ID in the vehicle entity
            vehicleFetchReq.predicate = NSPredicate(format: "id == \(userVehicleID)")
            
            // Attempt to fetch the context, if the result contains ONLY ONE entry, it has worked correctly so we can commit that data to the userData object!
            let vehicleResult = try objectContext.fetch(vehicleFetchReq) as [Vehicle2]
            if vehicleResult.count == 1
            {
                let theVehicle = vehicleResult.first
                
                // Get the make model and series variant strings to be combined in the next step
                let makeModel = theVehicle!.make! + " " + theVehicle!.model! + " "
                let seriesVariant = theVehicle!.series! + " " + theVehicle!.variant!
                
                // Set the specific vehicle consumption and image values
                specificVehicleString = makeModel + seriesVariant
                consumptionString = String(theVehicle!.consumptionLitres) + "L/100Km"
            }
            else{
                throw VehicleError.doesNotExist
            }
        }
        else{
            throw UserDataError.userDataLookupError
        }
        
        return (specificVehicleString, consumptionString, costString)
    }

    // Return the route data as a tuple
    func getRouteData() throws -> (fromStr: String, toStr: String, distanceStr: String)
    {
        var originString = ""
        var destinationString = ""
        var distanceString = ""
        
        // Our persistant container from the CoreData Model, and our user object
        let objectContext = persistentContainer.viewContext
        let userDataObject = try objectContext.fetch(userDataFetchReq)
        
        // Get the user data so that we can access the vehicle ID
        if let userData = userDataObject.first
        {
            // Set the origin and destination depending on the values set in user data
            originString = userData.userRouteStart!
            destinationString = userData.userRouteEnd!
        
            // Set the distance as per the distance unit being used
            distanceString = formatAsDistanceVal(inputValue: userData.userRouteDistance)
        }
        else{
            throw UserDataError.userDataLookupError
        }
        
        return (originString, destinationString, distanceString)
    }
}
