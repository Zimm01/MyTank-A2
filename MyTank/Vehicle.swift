//
//  Vehicle.swift
//  MyTank - Prototype
//
//  Created by Daniel Zimmerman on 26/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import Foundation

// This Struct Represents the Vehicle object that will be used by the application
struct Vehicle
{
    let make: String
    let model: String
    let variant: String
    let year: Int
    let consumptionLitres: Double
    
    var description: String
    {
        return String(year) + " " + make + " " + model + " " + variant
    }
    
    var consumption: String
    {
            
        return String(consumptionLitres) + "L/100Km"
    }
}

//  This extension is used so that two Vehicle objects can be compared using the '==' operator
extension Vehicle: Equatable
{
    static func ==(lhs: Vehicle, rhs: Vehicle)->Bool
    {
        // This will be more complex in the furture!
        return lhs.model == rhs.model
    }
}
