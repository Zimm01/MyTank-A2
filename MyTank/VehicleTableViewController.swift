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
    let greyBackground = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
    
    let cellRecolor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.94)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Set the Background Colour
        self.tableView.backgroundColor = greyBackground
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
    
    // Recolour every second cell passed in
    internal func cellColor(cell: inout UITableViewCell, index: Int)
    {
        if index % 2 == 1
        {
            cell.backgroundColor = cellRecolor
        }
    }
    
}
