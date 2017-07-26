//
//  CurrentUserData.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 25/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
//  This file is used to store our user data to be used in the application (persistance NR for prototype!)

import Foundation

class CurrentUserData
{
    //  Flag used to determine if session data exists or not!
    static private var userHasVehicle:Bool = false
    
    static private var routeAlreadyChosen:Bool = false
    
    //  The current vehicle object the user has selected
    static private var userVehicle:Vehicle?
    
    // The current cost per LITRE of petrol, placeholder value for the prototype is $1.30
    static private var costPerLitre:Double! = 1.40
    
    // The currency being used for this implementation
    static private var currencyUnit:String = "$"
    
    //  The current route object the user has selected
    static private var routeSelection:Route?
    
    
    //  For the complete version, this function will load the users last session and populate the member variables.
    init()
    {
        //  As Data persistance is NR at this time, this function is mostly a placeholder right now!!
    }
    
    // --- ACCESSORS ---
    
    //  Return whether or not the user has any session data.
    //  Currently this will always be FALSE on load up
    static func UserHasData()->Bool
    {
        return userHasVehicle
    }
    
    static func GetUserVehicle()->Vehicle
    {
        return userVehicle!
    }
    
    static func GetCostPerUnit()->String
    {
        return "@ " + formatAsCurrencyVal(inputValue: costPerLitre) + "/L"
    }
    
    static func GetRouteSelection()->Route
    {
        return routeSelection!
    }
    
    
    
    
    //  --- MUTATORS ---
    
    //  This call will update the current vehicle stored in the userdata object
    static func UpdateUserVehicle(newVehicle: Vehicle)->Bool
    {
        // First update the userVehicle object
        self.userVehicle = newVehicle
        
        // We want to perform an equality check here on the two
        // objects to ensure there wasnt an error of some kind.
        if userVehicle == newVehicle
        {
            userHasVehicle = true
            return true
        }
        
        return false
    }
    
    //  This call will update the current route stored in the userdata object
    static func UpdateRouteSelection(newRoute: Route)->Bool
    {
        // Update the routeSelection object
        self.routeSelection = newRoute
        
        if routeSelection == newRoute
        {
            routeAlreadyChosen = true
            return true
        }
        
        return false
    }
    
    // --- GENERAL FUNCTIONS ---
    
    static func CalculateFinalCost()->String
    {
        var grandTotal:Double = 0
        
        //  If for some reason the vehicle was not initialised, this IF statement will prevent the application encountering an unexpected error
        if userHasVehicle
        {
            let consumptionPerKM:Double = ((userVehicle?.consumptionLitres)! / 100)
            
            let totalDistance: Int = (routeSelection?.distance)!
            
            grandTotal = (consumptionPerKM * Double(totalDistance)) * costPerLitre
        }
        
        // Return the toal as a Currency String
        return formatAsCurrencyVal(inputValue: grandTotal)
    }
    
    
    
    // --- INTERNAL FUNCTIONS ---
    
    // This function takes a double value and returns it as a formatted currecny value, with 2 decimal places and a currency designator
    private static func formatAsCurrencyVal(inputValue: Double)->String
    {
        let totalAsString = String(format: "%.2f", inputValue)
        
        return currencyUnit + " " + totalAsString
    }
}
