//
//  CustomiseVehicleViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 14/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import CoreData

// Contains Functions to handle the vehicle customisation delegation and db commital controls
class CustomiseVehicleViewController: UIViewController, CommitDetailsToDBDelegate
{
    // Our View Model for this moduel
    internal let customiserViewModel = CustomiseVehicleViewModel()
    
    // The container which handles vehicle customisation
    var customSelectorContainer: CustomSelectorModuleViewController?
    
    // Button to segue to the next view, after commiting a vehicle to the Database
    @IBOutlet weak var segueButton: UIButton!
    
    // On Load..
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // Setup Segue, either for our Delegate or just in general
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "VehicleCustomiserModule"
        {
            customSelectorContainer = segue.destination as? CustomSelectorModuleViewController
            customSelectorContainer!.commitDetailsDelegate = self
        }
        else
        {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    // This action is executed on button push, it will request the series and variant from the container view and then pass those values to the view model
    @IBAction func commitVehicleAndTransition(button: UIButton)
    {
        if customiserViewModel.commitSeriesVairantToDB(tuple: customSelectorContainer!.retrieveVehicleSpecifics())
        {
            self.performSegue(withIdentifier: "LocationSelectionSegue", sender: self)
        }
        else
        {
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    // Placeholder so the class conforms with the Delegate Protocol
    internal func retrieveVehicleSpecifics() -> (series: String, variant: String) {
        return ("Error","Error")
    }
}
