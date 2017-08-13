//
//  VehicleModelViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 12/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

//
//  VehicleMakeViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 12/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import CoreData

class VehicleModelViewController: VehicleTableViewController
{
    // This connects the View Controller to the View Model
    let modelDataView = VehicleModelViewModel()
    
    //  This function is used to determine the table attributes as well as the number of rows to be used, based on the number of vehicles in the library
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return modelDataView.getNumObjects()
    }
    
    //  This function returns a cell with custom data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cellColor(cell: &cell, index: indexPath.row)
        
        cell.textLabel?.text = modelDataView.getRowDescription(index: indexPath.row)
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: modelDataView.getBodyType(index: indexPath.row))
        
        return cell
    }
    
    // Function used to Segue to the next view and save the user's selected vehicle
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //  Attempt to store the make selected in the user data object we will not advance the view if for some reson this fails, for app stability!
        if modelDataView.commitSelectedMake(index: indexPath.row)
        {
            self.performSegue(withIdentifier: "CustomiseVehicleSegue", sender: self)
        }
        else
        {
            print("There was an error selecting " + (tableView.cellForRow(at: indexPath)?.textLabel?.text)!)
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
}
