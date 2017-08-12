//
//  DropdownCell.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 8/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//

import UIKit

class DropdownCell: UITableViewCell {

    @IBOutlet weak var TopLabel: UILabel!
    
    @IBOutlet weak var BottomLabelHeightConstraint: NSLayoutConstraint!
    
    var showsDetails = false {
        didSet{
            BottomLabelHeightConstraint.priority = showsDetails ? 250 : 999
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
