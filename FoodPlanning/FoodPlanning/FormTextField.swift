//
//  FormTextField.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 29/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class FormTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = white
        font = fontMedium15
        
        attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSForegroundColorAttributeName: redColor, NSFontAttributeName: fontMedium15]
        )
    }
    
    func setAttributedPlaceholder(withText text: String) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSForegroundColorAttributeName: redColor, NSFontAttributeName: fontMedium15]
        )
    }

}
