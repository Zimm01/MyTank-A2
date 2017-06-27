//
//  CurrentVehicleVC.swift
//  MyTank - Prototype
//
//  Created by Daniel Zimmerman on 25/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class CurrentVehicleVC : UIViewController
{
    // Coonects to the headline label
    @IBOutlet weak var vehicleHeadline: UILabel!
    
    // Connects to the car data labels
    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var vehicleConsumption: UILabel!
    
    // Headline messages to be displayed
    let noVehicleMessage:String = "The Fuel Calculator"
    let hasVehicleMessage:String = "Current Vehicle"
    
    
    
    
    override func viewDidLoad()
    {
        //  IF the user has not used the app yet, display a standard message
        //  Otherwise we will display the name/attributes of their chosen vehicle
        if CurrentUserData.UserHasData() == false
        {
            vehicleHeadline.text = noVehicleMessage
            vehicleName.text = nil
            vehicleConsumption.text = nil
        }
        else
        {
            vehicleHeadline.text = hasVehicleMessage
            
            let currentVehicle:Vehicle = CurrentUserData.GetUserVehicle()
            
            vehicleName.text = currentVehicle.make
        }
    }
}

