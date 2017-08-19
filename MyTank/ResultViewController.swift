//
//  ResultViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 19/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit

class ResultViewController: UIViewController
{
    
    // Our View Model for this moduel
    internal let resultViewModel = ResultViewModel()
    
    // This is our TOTAL COST label
    @IBOutlet weak var resultTotalPrice: UILabel!
    
    // This is our PRICE PER (L/G) label
    @IBOutlet weak var resultPricePerUnit: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let finalCost:String = CurrentUserData.CalculateFinalCost()
        
        //  Finally, set the labels to show total cost and price per unit
        resultTotalPrice.text = finalCost
        resultPricePerUnit.text = CurrentUserData.GetCostPerUnit()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
