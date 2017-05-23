//
//  CustomDatePicker.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 15/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class CustomDatePicker: UIDatePicker {

    let black = UIColor(hex: "000000", alpha: 0.4)
    let white = UIColor(hex:"E4E0E0")
    
    override func draw(_ rect: CGRect) {
        //backgroundColor = blackуме
        backgroundColor = black
        setValue(white, forKey: "textColor")
        setValue(true, forKey: "highlightsToday")
    }

}
