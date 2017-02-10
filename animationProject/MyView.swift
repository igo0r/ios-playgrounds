//
//  MyView.swift
//  animationProject
//
//  Created by Igor Lantushenko on 26/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class MyView: UIView {
    var lastLocation = CGPoint(x: 0, y: 0)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        //Pan recognizer
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MyView.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        
        let blueColor = CGFloat(Int(arc4random() % 255)) / 255.0
        let redColor = CGFloat(Int(arc4random() % 255)) / 255.0
        let greenColor = CGFloat(Int(arc4random() % 255)) / 255.0
        
        self.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self)
        
        lastLocation = self.center
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(_ recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.superview)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }

}
