//
//  ProgressBarView.swift
//  ProgressBar
//
//  Created by Igor Lantushenko on 09/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {

    private var _progress: CGFloat = 0.0
    
    var progress: CGFloat {
        get {
            return _progress * bounds.width
        } set (newProgress) {
            if newProgress > 1.0 {
                _progress = 1.0
            } else if newProgress < 0.0 {
                _progress = 0.0
            } else {
                _progress = newProgress
            }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        ProgressBarDraw.drawProgressBar(frame: bounds, progress: progress)
    }

}
