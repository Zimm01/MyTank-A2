//
//  CurrentVehicleVC.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 25/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class HomeDisplayModuleVC : UIViewController
{
    // Coonects to the headline label
    @IBOutlet weak var vehicleHeadline: UILabel!
    
    @IBOutlet weak var iconLabel: UIImageView!
    // Connects to the car data labels
    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var vehicleConsumption: UILabel!
    
    @IBOutlet weak var displayImage: UIImageView!
    
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
            vehicleName.text = "No Current Vehicle"
            vehicleConsumption.text = "Get Started Below"
        }
        else
        {
            vehicleHeadline.text = hasVehicleMessage
            
            UIView.animate(withDuration: 1.5, animations:
            {
                self.vehicleHeadline.alpha = 0.0
            
            })
            
        }
    }
    
    
    
}

