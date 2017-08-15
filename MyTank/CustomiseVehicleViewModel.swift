//
//  VehicleCustomiserViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 14/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class CustomiseVehicleViewModel: MyTankViewModel
{
    // We want to place the values in an array to be used by displayed as in the view
    override init()
    {
        super.init()
    }
    
    func getMakeModelString() -> String
    {
        return "Mitsubishi Lancer"
    }
    
    func getVehicleMake() -> String
    {
        return "Mitsubishi"
    }
    
}
