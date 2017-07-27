//
//  StandardViewBox.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 27/07/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit

extension UIView
{
    
    @IBInspectable var shadow: Bool
    {
        get
        {
            return layer.shadowOpacity > 0.0
        }
        set
        {
            if newValue == true
            {
                self.addShadow()
            }
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
        shadowOffset: CGSize = CGSize(width: 1.0, height: 1.5),
        shadowOpacity: Float = 1,
        shadowRadius: CGFloat = 1)
    {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
