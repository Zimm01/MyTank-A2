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
}
