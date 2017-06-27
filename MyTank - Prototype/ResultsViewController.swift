//
//  ResultsViewController.swift
//  MyTank - Prototype
//
//  Created by Daniel Zimmerman on 27/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController
{
    @IBOutlet weak var tempCarInfo: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let hello:Vehicle = CurrentUserData.GetUserVehicle()
        
        //tempCarInfo.text = hello.make + " " + hello.model
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
