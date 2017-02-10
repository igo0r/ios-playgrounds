//
//  ProgressBarDraw.swift
//  ProgressBar
//
//  Created by Igor Lantushenko on 09/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

public class ProgressBarDraw: NSObject {
    
    public class func drawProgressBar(frame: CGRect = CGRect(x: 0, y: 0, width: 300, height: 16), progress: CGFloat = 183) {
        //Color declaration
        let color = UIColor(red: 0.847, green: 0.278, blue: 0.118, alpha: 1.000)
        
        //ProgressBorder drawing
        let progressBorderPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + 1, y: frame.minY + 1, width: floor((frame.width - 1) * 0.99666 + 0.5), height: 14), cornerRadius: 7)
        color.setStroke()
        progressBorderPath.lineWidth = 1
        progressBorderPath.stroke()
        
        //Progress active drawing
        let progressActivePath = UIBezierPath(roundedRect: CGRect(x: 1, y: 1, width: progress, height: 14), cornerRadius: 7)
        color.setFill()
        progressActivePath.fill()
    }

}
