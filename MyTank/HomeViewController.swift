//
//  HomeViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 27/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
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
   
    @IBAction func unwindToHomeViewController(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController)
    {
        //
    }
}
