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

        let calculationTuple: (total: String, perUnit: String) = resultDisplayContainer!.retrieveCalculations()
        
        //  Finally, set the labels to show total cost and price per unit
        resultTotalPrice.text = calculationTuple.total
        //resultPricePerUnit.text = CurrentUserData.GetCostPerUnit()
    }
    
    // Setup Segue, either for our Delegate or just in general
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ResultDisplaySegue"
        {
            resultDisplayContainer = segue.destination as? ResultModuleViewController
            resultDisplayContainer!.resultQueryDelegate = self
        }
    }
    
    // Placeholder function for delegate conformity, not to be used.
    func retrieveCalculations() -> (total: String, perUnit: String){ return (" "," ") }
}
