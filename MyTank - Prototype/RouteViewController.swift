//
//  ViewController.swift
//  MyTank - Prototype
//
//  Created by Daniel Zimmerman on 21/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class RouteViewController: UITableViewController
{
    
    // Our Current Route Data Model
    var routeData: RouteData! = RouteData()
    
    
    //  This function is used to determine the table attributes as well as the number of rows to be used, based on the number of routes in the library
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Set the Background Colour
        self.tableView.backgroundColor = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
        
        return routeData.getNumRoutes()
    }
    
    //  Populates each individual table cell with the details of each route!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        
        let thisRoute: Route = routeData.getRouteFromLibrary(key: indexPath.row)
        
        //  Our cell will contain a description of the route and the distance in kilometers
        cell.textLabel?.text = thisRoute.description
        cell.detailTextLabel?.text = String(thisRoute.distance)
        
        return cell
    }
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

