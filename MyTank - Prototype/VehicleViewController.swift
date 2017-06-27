//
//  VehicleViewController.swift
//  MyTank - Prototype
//
//  Created by Daniel Zimmerman on 26/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class VehicleViewController: UITableViewController
{
    // Our Current Vehicle Data Model
    var vehicleData: VehicleData! = VehicleData()
    
    
    //  This function is used to determine the table attributes as well as the number of rows to be used, based on the number of vehicles in the library
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        self.tableView.backgroundColor = UIColor.cyan
        return vehicleData.getNumVehicles()
    }
    
    // Populates each individual table cell with the details of each vehicle!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        
        let thisVehicle: Vehicle = vehicleData.getVehicleFromLibrary(key: indexPath.row)
        
        let makeModelString = String(thisVehicle.year) + " " + thisVehicle.make + " " + thisVehicle.model + " " + thisVehicle.variant
        
        cell.textLabel?.text = makeModelString
        
        return cell
    }
    
    // Will be used to commit the vehicle to the UserData section and move to the next scene in the storyboard!
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let row = indexPath.row
        
        //  Attempt to store the vehicle in 'CurrentUserData' we will not advance the view if for some reson this fails, for app stability!
        if CurrentUserData.UpdateUserVehicle(newVehicle: vehicleData.getVehicleFromLibrary(key: row))
        {
            self.performSegue(withIdentifier: "VehicleSelectionSegue", sender: self)
        }
        else
        {
            // TODO alert user the app has failed, somehow!
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
}
