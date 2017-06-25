//
//  CurrentUserData.swift
//  MyTank - Prototype
//
//  Created by Daniel Zimmerman on 25/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import Foundation

class CurrentUserData
{
    //  Flag used to determine if session data exists or not!
    static var hasCurrentCar:Bool = false
    
    
    
    //  For the complete version, this function will load the users last session and populate the member variables.
    init()
    {
        //  As Data persistance is NR at this time, this function is a placeholder right now!!
    }
    
    func hello()->Bool
    {
        return true;
        
    }
    
    //  Return whether or not the user has any session data.
    //  Currently this will always be FALSE on load up
    static func UserHasData()->Bool
    {
        return hasCurrentCar;
    }
    
}
