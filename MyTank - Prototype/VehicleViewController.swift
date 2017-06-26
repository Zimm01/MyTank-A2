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
        
        let makeModelString = vehicleData.getWholeVehicleString(key: indexPath.row)
        
        cell.textLabel?.text = makeModelString
        
        return cell
    }
    
    // Will be used to commit the vehicle to the UserData section and move to the next scene in the storyboard!
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
}
