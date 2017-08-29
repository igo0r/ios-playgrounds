//
//  VCExt.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 24/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension UIViewController {
    func configureView() {
        view.backgroundColor = UIColor.clear
        let backgroundImage = getBackgroundImage()
        view.insertSubview(backgroundImage, at: 0)
    }
    
    func getBackgroundImage() -> UIView {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        if isLandScapeMode() {
            backgroundImage.image = UIImage(named: "bg_l")
        } else {
            backgroundImage.image = UIImage(named: "bg_p")
        }
        
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = black07
        backgroundImage.addSubview(backgroundView)
        
        return backgroundImage
    }
    
    func isLandScapeMode() -> Bool {
        return  UIDevice.current.orientation.isLandscape
    }
}
