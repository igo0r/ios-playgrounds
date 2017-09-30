//
//  VCExt.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 24/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configureNavBar(withTitle: String) {
        let navBar = navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barStyle = .black
        self.title = withTitle
    }
    
    func goToPreviousViewController() {
        if self.getPreviousControllerFromNav() != nil {
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func getPreviousControllerFromNav() -> UIViewController? {
        if let childVC = navigationController?.childViewControllers {
            if childVC.count > 1 {
                return childVC[childVC.count - 2]
            }
        }
        
        return nil
    }
    
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
        backgroundView.backgroundColor = black08
        backgroundImage.addSubview(backgroundView)
        
        return backgroundImage
    }
    
    func isLandScapeMode() -> Bool {
        return  UIDevice.current.orientation.isLandscape
    }
}
