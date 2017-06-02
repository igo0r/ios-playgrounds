//
//  MealMeLoaderView.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 30/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class MealMeLoaderView: UIView {

    var angle: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let redLayer = CALayer()
        redLayer.frame = rect
        self.layer.addSublayer(redLayer)
        MeamMeLoader.drawCanvas2(frame: bounds, resizing: .aspectFill, minutesAngle: CGFloat(angle))
        
        /*
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEnd = CABasicAnimation(keyPath: "angle")
        animateStrokeEnd.duration = 3.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 160.0
        animateStrokeEnd.repeatCount = 100
        
        // add the animation
        self.layer.add(animateStrokeEnd, forKey: "fvfv")*/
    }

}
