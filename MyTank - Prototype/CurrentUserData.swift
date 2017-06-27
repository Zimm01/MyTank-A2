//
//  CurrentUserData.swift
//  MyTank - Prototype
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
    
    //  The current vehicle object the user has selected
    static private var userVehicle:Vehicle?
    
    
    //  For the complete version, this function will load the users last session and populate the member variables.
    init()
    {
        //  As Data persistance is NR at this time, this function is a placeholder right now!!
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

}
