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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        //  Finally, set the labels to show total cost and price per unit
       // resultTotalPrice.text = finalCost
        //resultPricePerUnit.text = CurrentUserData.GetCostPerUnit()
    }
    
    func retrieveCalculations() -> (total: String, perUnit: String)
    {
        var finalCostString:String = ""
        
        do{
            finalCostString = try resultViewModel.calculateFinalCost()
        }
        catch
        {
            finalCostString = "Error"
        }
        
        return (finalCostString,"bye")
    }
    
}
