//
//  ResultViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 19/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit

class ResultViewController: UIViewController, ResultsQueryDelegate
{
    // A reference to the container that handles reuslt display
    var resultDisplayContainer: ResultModuleViewController?
    
    // This is our TOTAL COST label
    @IBOutlet weak var resultTotalPrice: UILabel!
    
    // This is our PRICE PER (L/G) label
    @IBOutlet weak var resultPricePerUnit: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //let finalCost:String = resultViewModel.CalculateFinalCost()
        
        //  Finally, set the labels to show total cost and price per unit
        //resultTotalPrice.text = finalCost
        //resultPricePerUnit.text = CurrentUserData.GetCostPerUnit()
    }
    
    // Placeholder function for delegate conformity, not to be used.
    func retrieveCalculations() -> (total: String, perUnit: String){ return ("hi","bye") }
}
