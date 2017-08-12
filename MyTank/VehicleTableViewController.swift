//
//  VehicleTableViewController.swift
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

// Contains Common Functions for all Vehicle Table View Components of MYTank!!
class VehicleTableViewController: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Set the Background Colour
        self.tableView.backgroundColor = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    //  Replaces the Back item with the word "BACK" in the preceding view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
}
