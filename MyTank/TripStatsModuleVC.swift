//
//  TripStatsModuleVC.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 28/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class TripStatsModuleVC : UIViewController
{
    
    @IBOutlet weak var destinationSelected: UILabel!
    
    @IBOutlet weak var kilometersTravelled: UILabel!
    
    @IBOutlet weak var statsVehicleOutput: UILabel!

    @IBOutlet weak var statsConsumptionOutput: UILabel!
    
    //  This just displays if for some reason the data fails to update to the model
    let noDataMessage:String = "DataLoad Fail"
    
    
    override func viewDidLoad()
    {
        //  IF the user has not used the app yet, display a standard message
        //  Otherwise we will display the name/attributes of their chosen vehicle
        if CurrentUserData.UserHasData() == false
        {
            statsVehicleOutput.text = noDataMessage
            statsConsumptionOutput.text = noDataMessage
            destinationSelected.text = noDataMessage
            kilometersTravelled.text = noDataMessage

            //TODO: throw exeption
        }
        else
        {
            let userVehicle:Vehicle = CurrentUserData.GetUserVehicle()
            let routeSelection:Route = CurrentUserData.GetRouteSelection()

            
            statsVehicleOutput.text = userVehicle.description
            statsConsumptionOutput.text = userVehicle.consumption

            destinationSelected.text = routeSelection.description
            kilometersTravelled.text = String(routeSelection.tripKm)
        }
    }
}
