//
//  CustomiseSelectSubViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 14/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import CoreData

protocol CommitDetailsToDBDelegate{
    func retrieveVehicleSpecifics() -> (series: String, variant: String)
}

// Contains Common Functions for all Vehicle Table View Components of MYTank!!
class CustomSelectorModuleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    // Our View Model for this moduel
    internal let selectorViewModel = CustomSelectorModuleViewModel()
    
    // Our Delegate Protocol from the Parent View
    var commitDetailsDelegate: CommitDetailsToDBDelegate?
    
    // VEHICLE HEADLINE / LOGO
    @IBOutlet weak var currVehicleHeadline: UILabel!
    @IBOutlet weak var currVehicleLogo1: UIImageView!
    @IBOutlet weak var currVehicleLogo2: UIImageView!
    
    // MAKE/MODEL PICKER
    @IBOutlet weak var vehiclePicker: UIPickerView!
 
    // Vehicle Stats
    @IBOutlet weak var modelYearDisplay: UILabel!
    @IBOutlet weak var consumptionDisplay: UILabel!
    @IBOutlet weak var engineSizeDisplay: UILabel!
    
    // Number of sections in our picker
    internal let numberOfPickerSections = 2
    
    // size of our picker font
    internal let pickerFontSize: Float = 21.0
    
    // On View Load..
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set the deleate for the picker as this view
        self.vehiclePicker.delegate = self
        self.vehiclePicker.dataSource = self

        // We will set up the headline here, to display the current vehicle name
        setUpHeadline()
        
        // Update the statistics given by the initial picker positions
        updateStatistics()
    }
    
    // Returns the series and variant, used as part of a delegate method call from the parent view
    func retrieveVehicleSpecifics() -> (series: String, variant: String)
    {
        let series = selectorViewModel.getVehicleString(type: VehicleSortProperties.series)
        let variant = selectorViewModel.getVehicleString(type: VehicleSortProperties.variant)
        
        return (series, variant)
    }
    
    // Number of Components in the Vehicle Picker
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfPickerSections
    }
    
    // Number of Rows in each Component of the Vehicle Picker
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return selectorViewModel.getNumOfRows(forVar: VehicleSortProperties.series)
        }
        return selectorViewModel.getNumOfRows(forVar: VehicleSortProperties.variant)
    }
    
    // Title for each row in the Vehicle Picker, for either component
    internal func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        if component == 0{
            pickerLabel.text = selectorViewModel.getStringForRow(index: row, forVar: VehicleSortProperties.series)
        }
        else{
            pickerLabel.text = selectorViewModel.getStringForRow(index: row, forVar: VehicleSortProperties.variant)
        }
        
        pickerLabel.font = pickerLabel.font.withSize(CGFloat(pickerFontSize))
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
    
    // When a row is selected, update the view, so as to refelct the new picker options and vehicle statistics
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            // Set the new series and update the variant list
            selectorViewModel.updateVehicleSpecs(index: row, forSection: VehicleSortProperties.series)
            selectorViewModel.changeVehicleSeries(toSeriesIndex: row)
            
            pickerView.reloadAllComponents()
        }
    
        selectorViewModel.updateVehicleSpecs(index: pickerView.selectedRow(inComponent: 1), forSection: VehicleSortProperties.variant)
        
        // Update the statistics given by the current Series/Variant
        updateStatistics()
    }
    
    // Set the headline to reflect the current user Vehicle and that vhicle's make logo
    private func setUpHeadline()
    {
        currVehicleHeadline.text = selectorViewModel.getVehicleString(type: VehicleSortProperties.none)
        
        // Set the make images!
        currVehicleLogo1.image = UIImage(named: selectorViewModel.getVehicleString(type: VehicleSortProperties.make))
        currVehicleLogo2.image = UIImage(named: selectorViewModel.getVehicleString(type: VehicleSortProperties.make))
    }
    
    // At View Load, and whenever the a new make/variant is selected, then we will reload the statistics at the bottom of the view
    private func updateStatistics()
    {
        
        // Attempt to get the selected statistics, if this fails (due to an internal selection error) we wil return to the start
        do{
            let vehicleStats = try selectorViewModel.getVehicleStatistics()
            
            // If this succedes, set the values collected into their appropriate positions
            modelYearDisplay.text = vehicleStats.yearToYear
            consumptionDisplay.text = vehicleStats.consumption
            engineSizeDisplay.text = vehicleStats.engineSize
        }
        catch
        {
            print(error)
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
}
