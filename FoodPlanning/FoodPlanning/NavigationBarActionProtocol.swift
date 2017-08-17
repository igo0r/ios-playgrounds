//
//  NavigationBarActionProtocol.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 27/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

@objc protocol NavigationBarActionProtocol {
    func saveBarButtonPressed(_ sender: UIBarButtonItem!)
    func cancelBarButtonPressed(_ sender: UIBarButtonItem!)
}

extension NavigationBarActionProtocol where Self: UIViewController {
    func addBarLeftRightActionsWith(leftBtnStyle: UIBarButtonSystemItem, rightBtnStyle: UIBarButtonSystemItem) {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: rightBtnStyle, target: self, action: #selector(self.saveBarButtonPressed(_:)))
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: leftBtnStyle, target: self, action: #selector(self.cancelBarButtonPressed(_:)))
        
        rightBarButton.tintColor = green
        leftBarButton.tintColor = grayColor
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func addBarLeftRightActionsWith(leftBtnTitle: String, rightBtnTitle: String) {
        let rightBarButton = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(self.saveBarButtonPressed(_:)))
        let leftBarButton = UIBarButtonItem(title: leftBtnTitle, style: .plain, target: self, action: #selector(self.cancelBarButtonPressed(_:)))
        
        rightBarButton.tintColor = green
        leftBarButton.tintColor = grayColor
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
}
