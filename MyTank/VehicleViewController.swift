//
//  VehicleViewController.swift
//  MyTank
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
        // Set the Background Colour
        self.tableView.backgroundColor = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
        
        return vehicleData.getNumVehicles()
    }
    
    //  Populates each individual table cell with the details of each vehicle!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        
        let thisVehicle: Vehicle = vehicleData.getVehicleFromLibrary(key: indexPath.row)
        
        //  Our cell will contain a description of the car and the Consumption amount
        cell.textLabel?.text = thisVehicle.description
        cell.detailTextLabel?.text = thisVehicle.consumption
        
        return cell
    }
    
    
    //  Commit the vehicle to the UserData section and move to the next scene in the storyboard!
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
    
    //  Replaces the Back item with the word "BACK" in the preceding view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
    
}
