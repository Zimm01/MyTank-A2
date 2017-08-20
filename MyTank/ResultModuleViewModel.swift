//
//  ResultViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 19/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class ResultModuleViewModel: MyTankViewModel
{
    // Final Cost String
    private var finalCostString = ""
    
    // Getter for finalCostString
    var getFinalCost:String{
        get {return finalCostString}
    }
    
    // Cost Per unit of fuel
    private var costPerUnit = ""
    
    // Getter for costPerUnit
    var getCostPerUnit:String{
        get {return "@ " + costPerUnit}
    }
    
    // The Vheicle's Consumption Value
    private var vehicleConsumption:Float = 0
    
    // The name of this Vehicle
    private var thisVehicleString:String = ""
    
    // Init
    override init()
    {
        super.init()
        setVehicleSpecifics()
    }
    
    // Return the vehicle data as a tuple
    func getDisplayData() throws -> (vehicleStr: String, consumptionStr: String, routeStr: String, distanceStr:String)
    {
        var specificVehicleString = ""
        var consumptionString = ""
        var routeString = ""
        var distanceString = ""
        
        // Our persistant container from the CoreData Model, and our user object
        let objectContext = persistentContainer.viewContext
        let userDataObject = try objectContext.fetch(userDataFetchReq)
        
        // Get the user data so that we can access the vehicle ID
        if let userData = userDataObject.first
        {
            // Set the distance and route based on the UserData values
            routeString = userData.userRouteStart! + " To " + userData.userRouteEnd!
            distanceString = formatAsDistanceVal(inputValue: userData.userRouteDistance)
            // Set the vehicle Specifics
            specificVehicleString = thisVehicleString
            consumptionString = String(vehicleConsumption) + MyTankConstants.consumptionValue
        }
        else{
            throw UserDataError.userDataLookupError
        }
        
        return (specificVehicleString, consumptionString, routeString, distanceString)
    }
    
    // Return the final cost
    func calulateFinalCosts() -> Bool
    {
        var grandTotal: Float = 0
        do
        {
            // Our persistant container from the CoreData Model, and our user object
            let objectContext = persistentContainer.viewContext
            let userDataObject = try objectContext.fetch(userDataFetchReq)
            
            // Get the user data so that we can access the vehicle ID
            if let userData = userDataObject.first
            {
                // Perform the calculation here
                let consumptionPerKM:Float = (vehicleConsumption / 100)
                
                let totalDistance: Int32 = userData.userRouteDistance
                
                grandTotal = (consumptionPerKM * Float(totalDistance)) * userData.costPerUnit
            }
        }
        catch
        {
            return false
        }

        finalCostString = formatAsCurrencyVal(inputValue: grandTotal)
        
        return true
    }
    
    // This function sets the vehicle specifics from the UserData object
    private func setVehicleSpecifics()
    {
        do
        {
            // Our persistant container from the CoreData Model, and our user object
            let objectContext = persistentContainer.viewContext
            let userDataObject = try objectContext.fetch(userDataFetchReq)
        
            // Get the user data so that we can access the vehicle ID
            if let userData = userDataObject.first
            {
                // Set the final cost per unit
                costPerUnit = formatAsCurrencyVal(inputValue: userData.costPerUnit)
                
                let userVehicleID:Int32 = userData.vehicleID
            
                // Attempt to find the vehicle given by the ID in the vehicle entity
                vehicleFetchReq.predicate = NSPredicate(format: "id == \(userVehicleID)")
            
                // Attempt to fetch the context, if the result contains ONLY ONE entry, it has worked correctly so we can commit that data to the userData object!
                let vehicleResult = try objectContext.fetch(vehicleFetchReq) as [Vehicle]
                if vehicleResult.count == 1
                {
                    let theVehicle = vehicleResult.first
                
                    // Set the specific vehicle consumption and image values
                    thisVehicleString = theVehicle!.make! + " " + theVehicle!.model!
                    vehicleConsumption = theVehicle!.consumptionLitres
                }
                else{
                    throw VehicleError.doesNotExist
                }
            }
            else{
                throw UserDataError.userDataLookupError
            }
        }
        catch
        {
            print(error)
        }
    }
}
