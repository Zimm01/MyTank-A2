//
//  VehicleViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 26/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit
import CoreData

class VehicleViewController: UITableViewController
{
    //let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    //private var vehicles: [Vehicle2] = []
    
    // Our persistant container from the CoreData Model
    private let persistentContainer = NSPersistentContainer(name: "Model")
    
    // This variable is used to fetch data from the Data Model
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Vehicle2> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Vehicle2> = Vehicle2.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // ON load of this view
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
            }
            else {
                self.setupView()
                
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                self.updateView()
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        tableView.reloadData()
    }
    
    //  This function is used to determine the table attributes as well as the number of rows to be used, based on the number of vehicles in the library
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Set the Background Colour
        self.tableView.backgroundColor = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
        
        
        if let vehicles = fetchedResultsController.fetchedObjects{
         
            print(vehicles.count)
            return vehicles.count
        }
        return 0
    }
    
    
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
    
        // Fetch Vehicle
        let vehicle = fetchedResultsController.object(at: indexPath)
    
        // Setup cell
        cell.textLabel?.text = vehicle.make
        cell.detailTextLabel?.text = String(vehicle.consumptionLitres)

        return cell
    }
    
    private func updateView(){
        
        var hasQuotes = false
        
        if let quotes = fetchedResultsController.fetchedObjects {
            hasQuotes = quotes.count > 0
        }
        
        tableView.isHidden = !hasQuotes
        
    }
    
    private func setupView(){
        
        updateView()
    }
    
    //  Replaces the Back item with the word "BACK" in the preceding view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}

extension UITableViewController: NSFetchedResultsControllerDelegate
{
}
    /*
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
    
    */

