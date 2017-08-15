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
class CustomSelectorModuleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    //var changeDetailsDelegate: ChangeVehicleDetailsDelegate?
    
    // VEHICLE HEADLINE / LOGO
    @IBOutlet weak var currVehicleHeadline: UILabel!
    @IBOutlet weak var currVehicleLogo: UIImageView!
    
    // MAKE/MODEL PICKER
    @IBOutlet weak var vehiclePicker: UIPickerView!
 
    // Vehicle Stats
    @IBOutlet weak var modelYearDisplay: UILabel!
    @IBOutlet weak var consumptionDisplay: UILabel!
    @IBOutlet weak var engineSizeDisplay: UILabel!
    
    // Our View Model for this moduel
    let selectorViewModel = CustomSelectorModuleViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set the deleate for the picker as this view
        self.vehiclePicker.delegate = self
        self.vehiclePicker.dataSource = self

        // We will set up the headline here, to display the current vehicle name
        setUpHeadline()
    }
    
    
    var test = ["Red", "Green", "Blue"]
    
    var redTest = ["Red Dynamic"]

    var blueTest = ["Blue Dynamic"]
    
    var testVal = [""]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return test.count
        }
        return testVal.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return test[row]
        }
        return testVal[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            let thisSelection = test[row]
            if thisSelection == "Red"
            {
                testVal = redTest
            }
            else if thisSelection == "Blue"
            {
                testVal = blueTest
            }

            pickerView.reloadAllComponents()
        }
    }
    
    private func setUpHeadline()
    {
        currVehicleHeadline.text = selectorViewModel.getMakeModelString()
        currVehicleLogo.image = UIImage(contentsOfFile: selectorViewModel.getVehicleMake())
    }

}
