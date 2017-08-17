//
//  FormValidationLabel.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 29/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class FormValidationLabel: UILabel {
    
    var isValid: Bool = true {
        didSet {
            textColor = isValid ? UIColor.clear : redColor
            //setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = .clear
        font = fontRegular14
    }
    
    
}

