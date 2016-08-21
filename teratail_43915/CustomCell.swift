//
//  CustomCell.swift
//  teratail_43915
//
//  Created by Kentarou on 2016/08/10.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel   : UILabel!
    @IBOutlet weak var ageLabel    : UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var personal: PersonalData! {
        didSet {
            self.nameLabel.text    = personal.name + ", id = " + String(personal.id)
            self.ageLabel.text     = String(personal.age)
            self.addressLabel.text = personal.address
        }
    }
}
