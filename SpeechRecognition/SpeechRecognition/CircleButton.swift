//
//  CircleButton.swift
//  SpeechRecognition
//
//  Created by Igor Lantushenko on 12/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    
    
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
