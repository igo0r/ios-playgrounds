//
//  Shakeable.swift
//  MediTaco
//
//  Created by Igor Lantushenko on 07/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

protocol Shakeable {}

extension Shakeable where Self: UIView {
    func shake() {
        let anim = CABasicAnimation(keyPath: "position")
        anim.duration = 0.05
        anim.repeatCount = 5
        anim.autoreverses = true
        anim.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        anim.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        layer.add(anim, forKey: "position")
    }
}
