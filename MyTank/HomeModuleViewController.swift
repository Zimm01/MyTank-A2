//
//  HomeModuleViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 18/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit

protocol HomeVehicleQueryDelegate{
    func retriveIfUserHasVehicle() -> Bool
}

class HomeModuleViewController: UIViewController
{
    // Our View Model for this moduel
    internal let homeModuleViewModel = HomeModuleViewModel()
    
    // Our Delegate Protocol from the Parent View
    var vehicleQueryDelegate: HomeVehicleQueryDelegate?
    
    // Headline
    @IBOutlet weak var appTagLine: UILabel!
    
    // Top and bottom variable text
    @IBOutlet weak var topTextDisplay: UILabel!
    @IBOutlet weak var bottomTextDisplay: UILabel!
    
    // Image dsiplay view
    @IBOutlet weak var imageDisplay: UIImageView!

    // Vehicle delete icon
    @IBOutlet weak var deleteIcon: UIImageView!
    
    // On view load only...
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // This function will be used to simply set up the delete button
        deleteIcon.isUserInteractionEnabled = true
        
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeModuleViewController.deleteTapped))
        
        singleTap.numberOfTapsRequired = 1
        deleteIcon.addGestureRecognizer(singleTap)
    }
    
    // On View Load and reappear...
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(false)
        
        // We want to load the display values on load
        displayInformationVariableValues()
    }
    
    // Sets the label and image for either a default setting, or for the current vehicle the user has loaded into the database
    private func displayInformationVariableValues()
    {
        var textDataTuple: (headLine: String, topStr: String, bottomStr: String, imageStr: String)
        
        do
        {
            // First, check the user has data loaded at all
            if homeModuleViewModel.userHasVehicle()
            {
                textDataTuple = try homeModuleViewModel.getVehicleData()
                deleteIcon.isHidden = false
            }
            else
            {
                textDataTuple = homeModuleViewModel.getDefaultData()
                deleteIcon.isHidden = true
            }
            
            // Set the values given by the data tuple
            appTagLine.text = textDataTuple.headLine
            topTextDisplay.text = textDataTuple.topStr
            bottomTextDisplay.text = textDataTuple.bottomStr
            imageDisplay.image = UIImage(named: textDataTuple.imageStr)
        }
        catch
        {
            topTextDisplay.text = "A Serious Error Has Occured"
            
            // Attempt to remove the vehicle reference from the user object
            do
            {
                try homeModuleViewModel.deleteCurrentVehicle()
                bottomTextDisplay.text = "Vehicle ref removed!"
            }
            catch
            {
                bottomTextDisplay.text = "Vehicle ref not removed!!"
            }
        }
    }
    
    // Returns if a vehicle exists, used as part of a delegate method call from the parent view
    func retriveIfUserHasVehicle() -> Bool
    {
        return homeModuleViewModel.userHasVehicle()
    }
    
    // Function used to delete a vehicle reference from the UserData Object
    @objc private func deleteTapped()
    {
        let deleteAlert:UIAlertController = UIAlertController(title: "Delete Vehicle?", message: "Remove the current vehicle? This cannot be undone!", preferredStyle: UIAlertControllerStyle.alert)

        // Add the 'Cancel' Option to the alert view
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:
            {(alert: UIAlertAction) in Void()}))
        
        // Add the 'Delete' Option to the alert view
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler:
            {(alert: UIAlertAction) in self.deleteVehicleActions()}))

        self.present(deleteAlert, animated: true, completion: nil)
        
    }
    
    // Delete the vehicle from the userData object, and update the view to reflect the vehicle no longer existing.
    private func deleteVehicleActions()
    {
        do
        {
            // First, delete the vehicle entry in the userData object
            try homeModuleViewModel.deleteCurrentVehicle()
            
            // Now, update the view to reflect
            displayInformationVariableValues()
        }
        catch
        {
            bottomTextDisplay.text = "Vehicle ref not removed!!"
        }
    }
}
