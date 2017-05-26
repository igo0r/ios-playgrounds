//
//  CustomDatePicker.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 15/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class CustomDatePicker: UIDatePicker {
    
    override func draw(_ rect: CGRect) {
        //backgroundColor = blackуме
        //  backgroundColor = UIColor.clear//black
        setValue(white, forKey: "textColor")
        setValue(true, forKey: "highlightsToday")
    }

}
