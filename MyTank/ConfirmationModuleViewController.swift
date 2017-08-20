//
//  ConfirmationModuleViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 19/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit

class ConfirmationModuleViewController: UIViewController
{
    // Our View Model for this moduel
    internal let confirmationViewModel = ConfirmationModuleViewModel()
    
    @IBOutlet weak var vehicleDetailsLabel: UILabel!
    
    @IBOutlet weak var consumptionLabel: UILabel!
    @IBOutlet weak var costPerUnitLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        do
        {
            // First retrieve the tuples with out user data
            let vehicleDetailsTuple : (vehicleStr: String, consumptionStr: String, costStr: String) = try confirmationViewModel.getVehicleData()
            let routeDetailsTuple : (fromStr: String, toStr: String, distanceStr: String) = try confirmationViewModel.getRouteData()
        
            // Set the values into the vehicle label objects
            vehicleDetailsLabel.text = vehicleDetailsTuple.vehicleStr
            consumptionLabel.text = vehicleDetailsTuple.consumptionStr
            costPerUnitLabel.text = vehicleDetailsTuple.costStr
            
            // Set the values into the route label objects
            fromLabel.text = routeDetailsTuple.fromStr
            toLabel.text = routeDetailsTuple.toStr
            distanceLabel.text = routeDetailsTuple.distanceStr
        }
        catch
        {
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    
}
