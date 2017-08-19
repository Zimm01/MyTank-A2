//
//  HomeViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 27/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController, HomeVehicleQueryDelegate
{
    // A reference to the container that handles vehicle display
    var vehicleDisplayContainer: HomeModuleViewController?
    
    // The Segue button
    @IBOutlet weak var segueButton: UIButton!
    
    // On View Load...
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // Setup Segue, either for our Delegate or just in general
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "HomeVehicleDisplaySegue"
        {
            vehicleDisplayContainer = segue.destination as? HomeModuleViewController
            vehicleDisplayContainer!.vehicleQueryDelegate = self
        }
    }
    
    // This action is executed on button push, it transitions to either the vehicle slection stage, in the case there is no vehicle, or directly to the trip selection if there is
    @IBAction func vehicleDependantTransition(button: UIButton)
    {
        
        if (vehicleDisplayContainer?.retriveIfUserHasVehicle())!
        {
            // The user has a vehicle, therefore we don't have to select a new one, we can proced 
            // straight to route seelction
            self.performSegue(withIdentifier: "LocationSelectionSegue", sender: self)
        }
        else
        {
            // The User has no Vehicle, procede to the selection stage
            self.performSegue(withIdentifier: "VehicleMakeSelectionSegue", sender: self)
        }
    }
   
    @IBAction func unwindToHomeViewController(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController)
    {
        //
    }
    
    // Placeholder function for delegate conformity, not to be used.
    internal func retriveIfUserHasVehicle() -> Bool { return false }
}
