//
//  EnumCommon.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 13/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import Foundation

// Represents user key data present names
enum UserKeys : String
{
    case preLoaded = "isPreloaded"
    
    case vehicleFileSize = "vehicFileSize"
}

// Represents vehicle body types
enum BodyTypes : String
{
    case smallCar = "CAR-SM"
    
    case mediumCar = "CAR-MD"
    
    case largeCar = "CAR-LG"
    
    case suvCar = "SUV"
    
    case fwd = "FWD"
    
    case uteCar = "UTE"
    
    case truck = "TRUCK"
    
    case van = "VAN"
}

// Represents sort properties of a Vehicle Object
enum VehicleSortProperties : String
{
    case make
    
    case model
    
    case series
    
    case variant
    
    case none
}
