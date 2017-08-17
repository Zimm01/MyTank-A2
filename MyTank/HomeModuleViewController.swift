//
//  HomeModuleViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 18/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import CoreData

class HomeModuleViewController: UIViewController
{
    // Our View Model for this moduel
    internal let homeModuleViewModel = HomeModuleViewModel()
    
    @IBOutlet weak var appTagLine: UILabel!
    
    @IBOutlet weak var topTextDisplay: UILabel!
    
    @IBOutlet weak var bottomTextDisplay: UILabel!
    
    @IBOutlet weak var imageDisplay: UIView!
    
    
    
    // On View Load...
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToHomeViewController(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController)
    {
        //
    }
}
