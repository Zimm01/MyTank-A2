//
//  ResultModuleViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 19/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit

protocol ResultsQueryDelegate{
    func retrieveCalculations() -> (total: String, perUnit: String)
}

class ResultModuleViewController: UIViewController
{
    // Our View Model for this moduel
    internal let resultViewModel = ResultModuleViewModel()
    
    // Our Delegate Protocol from the Parent View
    var resultQueryDelegate: ResultsQueryDelegate?
    
    // Our Output Labels
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var vehicleSimpleLabel: UILabel!
    @IBOutlet weak var consumptionLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        do
        {
            // First retrieve the tuples with out user data
            let displayDetailsTuple : (vehicleStr: String, consumptionStr: String, routeStr: String, distanceStr:String) = try resultViewModel.getDisplayData()
            
            // Set the values into the vehicle label objects
            fromToLabel.text = displayDetailsTuple.routeStr
            totalDistanceLabel.text = displayDetailsTuple.distanceStr
            vehicleSimpleLabel.text = displayDetailsTuple.vehicleStr
            consumptionLabel.text = displayDetailsTuple.consumptionStr

        }
        catch
        {
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    // Delegate method to return values to the parent view
    func retrieveCalculations() -> (total: String, perUnit: String)
    {
        var finalCostString:String = ""
        var perUnit = ""
        

        if resultViewModel.calulateFinalCosts()
        {
                finalCostString = resultViewModel.getFinalCost
                perUnit = resultViewModel.getCostPerUnit

        }
        
        return (finalCostString, perUnit)
    }
    
}
