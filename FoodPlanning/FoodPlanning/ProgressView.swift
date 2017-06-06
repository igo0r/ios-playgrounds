//
//  ProgressView.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 05/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit

class ProgressView {
    func drawProgresBar2(dash: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let color19 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let color20 = UIColor(red: 0.267, green: 0.239, blue: 0.239, alpha: 1.000)
        let greenGradientColor = UIColor(red: 0.000, green: 1.000, blue: 0.825, alpha: 1.000)
        let gradientColor4 = UIColor(red: 0.849, green: 0.220, blue: 0.179, alpha: 1.000)
        let gradientColor5 = UIColor(red: 0.429, green: 0.499, blue: 0.802, alpha: 1.000)
        let greenGradientColor2 = UIColor(red: 0.166, green: 0.514, blue: 0.166, alpha: 1.000)
        let color21 = UIColor(red: 0.172, green: 0.906, blue: 0.258, alpha: 0.140)
        
        let greenGradient = CGGradient(colorsSpace: nil, colors: [greenGradientColor2.cgColor, greenGradientColor2.blended(withFraction: 0.5, of: greenGradientColor).cgColor, greenGradientColor.cgColor] as CFArray, locations: [0.06, 1, 1])!
        
        let gradient = CGGradient(colorsSpace: nil, colors: [gradientColor4.cgColor, gradientColor4.blended(withFraction: 0.5, of: gradientColor5).cgColor, gradientColor5.cgColor] as CFArray, locations: [0.09, 0.47, 0.63])!
        
        //// underGroup
        //// MaskOval 2 Drawing
        
        let maskOval2Path = UIBezierPath(ovalIn: CGRect(x: 173.5, y: 335.5, width: 66, height: 66))
        color21.setFill()
        maskOval2Path.fill()
        
        color20.setStroke()
        maskOval2Path.lineWidth = 3
        maskOval2Path.stroke()
        
        //// ExerciseOval 2 Drawing
        let exerciseOval2Path = UIBezierPath(ovalIn: CGRect(x: 191.5, y: 353.5, width: 30, height: 30))
        
        context.saveGState()
        exerciseOval2Path.addClip()
        
        context.drawLinearGradient(gradient, start: CGPoint(x: 206.5, y: 353.5), end: CGPoint(x: 206.5, y: 383.5), options: [])
        context.restoreGState()
        color19.setStroke()
        exerciseOval2Path.lineWidth = 3
        exerciseOval2Path.stroke()
            
        //// Group
        context.saveGState()
        context.setBlendMode(.sourceAtop)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
            
        //// ColorGroup
        //// MaskOval Drawing
        let maskOvalPath = UIBezierPath(ovalIn: CGRect(x: 173, y: 333, width: 67, height: 67))
        context.saveGState()
        maskOvalPath.addClip()
        context.drawLinearGradient(greenGradient, start: CGPoint(x: 206.5, y: 333), end: CGPoint(x: 206.5, y: 400), options: [])
        context.restoreGState()
        color20.setStroke()
        maskOvalPath.lineWidth = 4
        maskOvalPath.stroke()
        
        //// ExerciseOval Drawing
        let exerciseOvalPath = UIBezierPath(ovalIn: CGRect(x: 191, y: 351, width: 31, height: 31))
        context.saveGState()
        exerciseOvalPath.addClip()
        context.drawLinearGradient(gradient, start: CGPoint(x: 206.5, y: 351), end: CGPoint(x: 206.5, y: 382), options: [])
        context.restoreGState()
        color19.setStroke()
        exerciseOvalPath.lineWidth = 1
        exerciseOvalPath.stroke()
        
        //// Mask Drawing
        context.saveGState()
        context.translateBy(x: 207, y: 366)
        context.rotate(by: -88.4 * CGFloat.pi/180)
        
        context.saveGState()
        context.setBlendMode(.destinationIn)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let maskPath = UIBezierPath()
        
        maskPath.move(to: CGPoint(x: 23.59, y: -0.75))
        
        maskPath.addCurve(to: CGPoint(x: -0.77, y: 23.62), controlPoint1: CGPoint(x: 23.59, y: 12.71), controlPoint2: CGPoint(x: 12.68, y: 23.62))
        maskPath.addCurve(to: CGPoint(x: -25.14, y: -0.75), controlPoint1: CGPoint(x: -14.23, y: 23.62), controlPoint2: CGPoint(x: -25.14, y: 12.71))
        maskPath.addCurve(to: CGPoint(x: -0.77, y: -25.11), controlPoint1: CGPoint(x: -25.14, y: -14.2), controlPoint2: CGPoint(x: -14.23, y: -25.11))
        maskPath.addCurve(to: CGPoint(x: 23.59, y: -0.75), controlPoint1: CGPoint(x: 12.68, y: -25.11), controlPoint2: CGPoint(x: 23.59, y: -14.2))
        maskPath.close()
            
        color19.setStroke()
        maskPath.lineWidth = 17
        maskPath.lineCapStyle = .round
        context.saveGState()
        context.setLineDash(phase: 0, lengths: [dash, 161])
        maskPath.stroke()
        context.restoreGState()
            
        context.endTransparencyLayer()
        context.restoreGState()
        context.restoreGState()
        context.endTransparencyLayer()
        context.restoreGState()
    }
}
