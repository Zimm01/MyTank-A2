//
//  ConfirmationViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 19/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit

class ConfirmationViewController: UIViewController
{
    // This action is executed on button push, it transitions to either the vehicle slection stage, in the case there is no vehicle, or directly to the trip selection if there is
    @IBAction func vehicleDependantTransition(button: UIButton)
    {
        self.performSegue(withIdentifier: "ResultViewSegue", sender: self)
    }
}
