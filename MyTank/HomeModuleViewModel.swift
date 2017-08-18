//
//  HomeModuleViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 18/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class HomeModuleViewModel: MyTankViewModel
{
    override init()
    {
        super.init()
    }
    
    func userHasVehicle() -> Bool
    {
        return true
    }
    
    func getVehicleData() throws -> (headLine: String, topStr: String, bottomStr: String, imageStr: String)
    {
        return ("The Fuel Calculator", "No Vehicle Selected", "Get Started Below", "default")
    }
    
    func getDefaultData() throws -> (headLine: String, topStr: String, bottomStr: String, imageStr: String)
    {
        // Headline, Top Display String, Bottom Display String and Default Image name in xcasset
        return ("The Fuel Calculator", "No Vehicle Selected", "Get Started Below", "default")
    }
}
