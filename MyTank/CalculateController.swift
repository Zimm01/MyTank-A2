//
//  CalculateController.swift
//  MyTank
//
//  Created by Joachim McClain on 2/7/17.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class CalculateController: UIViewController
{

    // This will have a confirmation message that calls the chosen 
    // vehicle and route in the final version of the app
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //  Replaces the Back item with the word "BACK" in the preceding view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }

}
