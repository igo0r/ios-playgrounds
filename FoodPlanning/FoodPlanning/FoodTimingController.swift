//
//  FoodTimingController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 29/04/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class FoodTimingController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
    }
    
    
    func configureNavBar() {
        if let navItem = self.navigationController?.navigationBar.topItem {
            let navBar = navigationController?.navigationBar
            navBar?.isTranslucent = false
            navItem.title = "New food timing"
            
            navItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "Back.png"), style: UIBarButtonItemStyle.plain, target: nil, action: nil), animated: false)
            navItem.leftBarButtonItem?.tintColor = UIColor(hex: "E4E0E0", alpha: 1)
            
            navItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "Path.png"), style: UIBarButtonItemStyle.plain, target: nil, action: nil), animated: false)
            navItem.rightBarButtonItem?.tintColor = UIColor(hex: "E7847E", alpha: 1)
            
            UIApplication.shared.statusBarStyle = .lightContent
            
        }
    }
    
}
