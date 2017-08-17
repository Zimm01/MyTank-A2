//
//  CustomiseVehicleViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 14/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import CoreData

// Contains Common Functions for all Vehicle Table View Components of MYTank!!
class CustomiseVehicleViewController: UIViewController, CommitDetailsToDBDelegate
{
    var customSelectorContainer: CustomSelectorModuleViewController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        customSelectorContainer?.commitToDBSignal(sendCommit: true)
        print("hi")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("try")
        if segue.identifier == "CustomiseVehicleSegue"
        {
            customSelectorContainer = segue.destination as? CustomSelectorModuleViewController
            customSelectorContainer!.commitDetailsDelegate = self
        }
    }

    func commitToDBSignal(sendCommit: Bool)
    {
        print("huh")
    }
}
