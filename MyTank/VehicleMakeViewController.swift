//
//  VehicleMakeViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 12/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import CoreData

class VehicleMakeViewController: UITableViewController
{
    let makeDataView = VehicleMakeViewModel()
    
    override func viewDidLoad()
    {

    }
    
    private func setupView()
    {
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }

    //  This function is used to determine the table attributes as well as the number of rows to be used, based on the number of vehicles in the library
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Set the Background Colour
        self.tableView.backgroundColor = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
        
        print(makeDataView.getNumObjects())
        return makeDataView.getNumObjects()
    }
    
    //  This function returns a cell with custom data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        

    }
    
    //  Replaces the Back item with the word "BACK" in the preceding view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
}
