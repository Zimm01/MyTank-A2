//
//  CustomiseSelectSubViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 14/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import CoreData

// Contains Common Functions for all Vehicle Table View Components of MYTank!!
class CustomSelectModuleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    //var changeDetailsDelegate: ChangeVehicleDetailsDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.testSpinner.delegate = self
        self.testSpinner.dataSource = self

    }
    
    @IBOutlet weak var testSpinner: UIPickerView!
    
    var test = ["Red", "Green", "Blue"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return test.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return test[row]
    }

}
