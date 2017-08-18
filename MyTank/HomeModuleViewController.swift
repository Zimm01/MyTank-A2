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
    
    // Headline
    @IBOutlet weak var appTagLine: UILabel!
    
    // Top and bottom variable text
    @IBOutlet weak var topTextDisplay: UILabel!
    @IBOutlet weak var bottomTextDisplay: UILabel!
    
    // Image dsiplay view
    @IBOutlet weak var imageDisplay: UIImageView!
    
    
    
    
    // On View Load...
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var textDataTuple: (headLine: String, topStr: String, bottomStr: String, imageStr: String)

        do
        {
            // First, check the user has data loaded at all
            if homeModuleViewModel.userHasVehicle()
            {
                textDataTuple = try homeModuleViewModel.getVehicleData()
            }
            else
            {
                textDataTuple = try homeModuleViewModel.getDefaultData()
            }
        
            appTagLine.text = textDataTuple.headLine
            topTextDisplay.text = textDataTuple.topStr
            bottomTextDisplay.text = textDataTuple.bottomStr
            imageDisplay.image = UIImage(named: textDataTuple.imageStr)
        }
        catch
        {
            topTextDisplay.text = "Error"
        }
    }
}
