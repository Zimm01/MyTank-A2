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
    
    // Return the final cost
    func calculateFinalCost() throws -> String
    {
        var grandTotal:Double = 0
        var vehicleConsumption:Float = 0
        
        //  If for some reason the vehicle was not initialised, this IF statement will prevent the application encountering an unexpected error
        if userHasVehicle()
        {
            // Our persistant container from the CoreData Model, and our user object
            let objectContext = persistentContainer.viewContext
        
            // Attempt to find the vehicle given by the ID in the vehicle entity
            vehicleFetchReq.predicate = NSPredicate(format: "id == \(vehicleSelected)")
            
            // Attempt to fetch the context, if the result contains ONLY ONE entry, it has worked correctly so we can commit that data to the userData object!
            let vehicleResult = try objectContext.fetch(vehicleFetchReq) as [Vehicle2]
            if vehicleResult.count == 1
            {
                vehicleConsumption = (vehicleResult.first?.consumptionLitres)!
            }
            else{
                throw VehicleError.doesNotExist
            }
        }
        
        // Return the toal as a Currency String
        return formatAsCurrencyVal(inputValue: grandTotal)
    }
    
    
    // This function takes a double value and returns it as a formatted currecny value, with 2 decimal places and a currency designator
    private func formatAsCurrencyVal(inputValue: Double)->String
    {
        let totalAsString = String(format: "%.2f", inputValue)
        
        return MyTankConstants.currencyUnit + " " + totalAsString
    }
}
