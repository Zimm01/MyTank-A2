//
//  VehicleData.swift
//  MyTank - Prototype
//
//  Created by Daniel Zimmerman on 26/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import Foundation

class VehicleData
{
    // Dictionary that contains the car valuse to be used in the program, for the protype, these values are hard-coded!
    private var vehicleLibrary = [Vehicle(make: "Mitsubishi", model: "Lancer", variant: "Activ", year: 2012, litersPerKM: 6.7), Vehicle(make: "Mazda", model: "3", variant: "Touring", year: 2017, litersPerKM: 5.9)]
    
    
    // Return the number of Vehicles in the vehicleLibrary
    func getNumVehicles()->Int
    {
        return vehicleLibrary.count
    }
    
    // Test Function! Return string representation of vehicle
    func getWholeVehicleString(key: Int)->String
    {
        var buffer: String
        
        buffer = String(vehicleLibrary[key].year) + " " + vehicleLibrary[key].make + " " + vehicleLibrary[key].model + " " + vehicleLibrary[key].variant
        
        return buffer
    }
}
