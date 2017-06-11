//
//  TimeEventProgressView.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 09/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class TimeEventProgressView: UIView {

    var progress: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        //ProgressView.drawProgresBar2()
    }

}
