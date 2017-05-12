//
//  UIViewUtils.swift
//  UIViewHomeWork
//
//  Created by Igor Lantushenko on 09/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit

class UIViewUtils {
    
    static let rectangleWidth: Double = 20
    static let rectangleHeight: Double = 20
    static let distanceBetweenRectangles: Double = 10
    static let backgorundColor = UIColor.black
    
    /*
     Draw a circle target
     rectangleWidth should be equal to rectangleHeight
     */
    static func buildCircleTargetWith(count: Int, inView view: UIView) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        let firstCircleDiameter = 2 * Double(count - 1) * distanceBetweenRectangles + rectangleWidth
        
        let posX = calculatePositionX(withWidth: firstCircleDiameter, forView: view)
        let posY = calculatePositionY(withHeight: firstCircleDiameter, forView: view)
        
        for counter in 0..<count
        {
            let distanceCounter = distanceBetweenRectangles * Double(counter)
            
            let currentX = posX + distanceCounter
            let currentY = posY + distanceCounter
            
            let currentWidth = firstCircleDiameter - 2 * distanceCounter
            let rect = CGRect(x: currentX, y: currentY, width: currentWidth, height: currentWidth)
            
            let subView = UIView(frame: rect)
            subView.layer.cornerRadius = CGFloat(currentWidth / 2)
            
            if counter % 2 == 0 {
                subView.backgroundColor = UIColor.blue
            } else {
                subView.backgroundColor = UIColor.red
            }
            
            view.addSubview(subView)
        }
    }
    
    /*
     Build rectangles in multiple raws with or without centering
     */
    static func buildRectanglesInMultipleRaws(withCentering: Bool, forCount count: Int, inView view: UIView) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        let width = getRectanglesWidth(forCount: count)
        let height = getRectanglesHeight(forCount: count)
        
        let posX = calculatePositionX(withWidth: width, forView: view)
        let posY = calculatePositionY(withHeight: height, forView: view)
        
        for i in 0..<count
        {
            var currentX = posX
            let currentY = posY + Double(i) * rectangleHeight + distanceBetweenRectangles * Double(i)
            
            if withCentering
            {
                let halfSuperViewWidth = Double(view.frame.width) / 2
                let halfRectangleWidth = rectangleWidth / 2
                let halfDistanceBetweenRectangles = distanceBetweenRectangles / 2
                
                currentX = halfSuperViewWidth - halfRectangleWidth - Double(i) * halfRectangleWidth - halfDistanceBetweenRectangles * Double(i)
            }
            
            drawLineOfRectanglesWith(count: i + 1, startPosX: currentX, startPosY: currentY, forView: view)
        }
    }
    
    /*
     Build rectangles for view in one raw with centering
     */
    static func buildRectanglesInOneRawWith(count: Int, forView view: UIView) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        let width = getRectanglesWidth(forCount: count)
        let height = getRectanglesHeight(forCount: 1)
        
        let posX = calculatePositionX(withWidth: width, forView: view)
        let posY = calculatePositionY(withHeight: height, forView: view)
        
        drawLineOfRectanglesWith(count: count, startPosX: posX, startPosY: posY, forView: view)
    }
    
    /*
     Create line of rectanges with exact count and start in exact point
     */
    static func drawLineOfRectanglesWith(count: Int, startPosX: Double, startPosY: Double, forView view: UIView) {
        for i in 0..<count
        {
            let currentX = startPosX + Double(i) * rectangleWidth + Double(i) * distanceBetweenRectangles
            let rect = CGRect(x: currentX, y: startPosY, width: rectangleWidth, height: rectangleHeight)
            let subView = UIView(frame: rect)
            
            subView.backgroundColor = backgorundColor
            view.addSubview(subView)
        }
    }
    
    /*
     Get position Y to start from
     */
    static func calculatePositionY(withHeight: Double, forView superView: UIView) -> Double {
        let superViewHeight = Double(superView.frame.height)
        
        return superViewHeight / 2 - withHeight / 2
    }
    
    /*
     Get position X to start from
     */
    static func calculatePositionX(withWidth: Double, forView superView: UIView) -> Double {
        let superViewWidth = Double(superView.frame.width)
        
        return superViewWidth / 2 - withWidth / 2
    }
    
    /*
     Get height of the whole block
     */
    static func getRectanglesHeight(forCount: Int) -> Double {
        return rectangleHeight * Double(forCount) + distanceBetweenRectangles * (Double(forCount) - 1)
    }
    
    /*
     Get width of the whole block
     */
    static func getRectanglesWidth(forCount: Int) -> Double {
        return rectangleWidth * Double(forCount) + distanceBetweenRectangles * (Double(forCount) - 1)
    }
}
