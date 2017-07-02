//
//  ConfirmationModuleVC.swift
//  MyTank - Prototype
//
//  Created by Joachim McClain on 3/7/17.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class ConfirmationModuleVC : UIViewController
{
    
    @IBOutlet weak var destinationSelected: UILabel!
    
    @IBOutlet weak var vehicleSelected: UILabel!
    
    //  This just displays if for some reason the data fails to update to the model
    let noDataMessage:String = "DataLoad Fail"
    
    
    override func viewDidLoad()
    {
        //  IF the user has not used the app yet, display a standard message
        //  Otherwise we will display the name/attributes of their chosen vehicle
        if CurrentUserData.UserHasData() == false
        {
            vehicleSelected.text = noDataMessage
            destinationSelected.text = noDataMessage
            //TODO: throw exeption
        }
        else
        {
            let userVehicle:Vehicle = CurrentUserData.GetUserVehicle()
            let routeSelection:Route = CurrentUserData.GetRouteSelection()
            
            
            vehicleSelected.text = userVehicle.description
            
            destinationSelected.text = routeSelection.description
        }
    }
}
