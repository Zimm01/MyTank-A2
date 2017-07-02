//
//  Route.swift
//  MyTank - Prototype
//
//  Created by Joachim McClain on 2/7/17.
//  Copyright © 2017 CPT224. All rights reserved.
//

import Foundation

// This Struct Represents the Route object that will be used by the application. These routes are pre-picked and hard coded but will replaced by Google Maps Direction API in the final version
struct Route
{
    let origin: String
    let destination: String
    let distance: Int
    
    var description: String
    {
        return origin + " to " + destination + " is: "
    }
    
}

//  This extension is used so that two Route objects can be compared using the '==' operator
extension Route: Equatable
{
    static func ==(lhs: Route, rhs: Route)->Bool
    {
        // This will be more complex in the furture!
        return lhs.distance == rhs.distance
    }
}
