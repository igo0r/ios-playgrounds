//
//  ShapeView.swift
//  IOS10DrawShapesTutorial
//
//  Created by Igor Lantushenko on 02/04/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

enum ShapeType: Int {
    case rectangle = 0
    case lines
    case circle
}

class ShapeView: UIView {

    var currentShapeType = ShapeType(rawValue: 0)
    
    init(frame: CGRect, shape: Int) {
        super.init(frame: frame)
        
        if let shape = ShapeType(rawValue: shape) {
            currentShapeType = shape
        } else {
            fatalError("Wrong shape type")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        switch currentShapeType! {
        case .rectangle: drawRect()
        case .lines: drawLines()
        case .circle: drawCircle()
        }
    }
    
    func drawLines() {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        ctx.beginPath()
        
        ctx.setLineWidth(5)
        ctx.move(to: CGPoint(x: 20, y: 20))
        
        ctx.addLine(to: CGPoint(x: 250, y: 100))
        ctx.addLine(to: CGPoint(x: 100, y: 200))
        
        ctx.closePath()
        ctx.strokePath()
    }
    
    func drawCircle() {
        let center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        ctx.setLineWidth(5)
        ctx.addArc(center: center, radius: 100, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        ctx.strokePath()
    }
    
    func drawRect() {
        let center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
        let rectWidth: CGFloat = 100.0
        let rectHeight: CGFloat = 100.0
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        ctx.addRect(CGRect(x: center.x  - (0.5 * rectWidth), y: center.y  - (0.5 * rectHeight), width: rectWidth, height: rectHeight))
        ctx.setLineWidth(10)
        ctx.setStrokeColor(UIColor.gray.cgColor)
        ctx.strokePath()
        
        ctx.setFillColor(UIColor.green.cgColor)
        
        ctx.addRect(CGRect(x: center.x  - (0.5 * rectWidth), y: center.y  - (0.5 * rectHeight), width: rectWidth, height: rectHeight))
        ctx.fillPath()
        
    }
}
