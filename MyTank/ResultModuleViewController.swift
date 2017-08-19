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
    
    // This is our TOTAL COST label
    @IBOutlet weak var resultTotalPrice: UILabel!
    
    // This is our PRICE PER (L/G) label
    @IBOutlet weak var resultPricePerUnit: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // let finalCost:String = resultViewModel.CalculateFinalCost()
        
        //  Finally, set the labels to show total cost and price per unit
       // resultTotalPrice.text = finalCost
        //resultPricePerUnit.text = CurrentUserData.GetCostPerUnit()
    }
    
    func retrieveCalculations() -> (total: String, perUnit: String)
    {
       
        
        return ("hi","bye")
    }
    
}
