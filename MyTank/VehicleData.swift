//
//  VehicleData.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 26/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
//  This file is used to store our Vehicle Dictionary and associated getter functions (mutators NR for prototype!)

import Foundation

class VehicleData
{
    //let dbInstance = MyTankDB()
    //private let db: Connection?
    
    
    
    // Dictionary that contains the car valuse to be used in the program, for the protype, these values are hard-coded!
    private var vehicleLibrary = [Vehicle(make: "Mitsubishi", model: "Lancer", variant: "Activ", year: 2012, consumptionLitres: 8.5), Vehicle(make: "Mazda", model: "3", variant: "Touring", year: 2017, consumptionLitres: 4.3)]
    
    
    // Return the number of Vehicles in the vehicleLibrary
    func getNumVehicles()->Int
    {
        return vehicleLibrary.count
    }
    
    // Get a vehicle, by index position in the library
    func getVehicleFromLibrary(key: Int)->Vehicle
    {
        return vehicleLibrary[key]
    }
}
