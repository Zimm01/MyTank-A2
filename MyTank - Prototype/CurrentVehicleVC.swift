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
    let noVehicleMessage:String = "Test"
    let hasVehicleMessage:String = "Current Vehicle"
    
    
    
    
    override func viewDidLoad()
    {
        if CurrentUserData.UserHasData() == false
        {
            vehicleHeadline.text = noVehicleMessage
            vehicleName.text = nil
            vehicleConsumption.text = nil
        }
        else
        {
            vehicleHeadline.text = hasVehicleMessage
        }
    }
}

