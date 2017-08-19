//
//  EnumCommon.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 13/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import Foundation

// Enum used to define vehicle body types
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

// Enum used to define sort properties of a Vehicle Object
enum VehicleSortProperties : String
{
    case make
    
    case model
    
    case series
    
    case variant
}
