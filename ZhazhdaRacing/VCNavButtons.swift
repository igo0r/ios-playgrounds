//
//  VCNavButtons.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 01/09/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

@objc protocol VCNavButtons {
    func rightBarButtonPressed(_ sender: UIBarButtonItem!)
    func leftBarButtonPressed(_ sender: UIBarButtonItem!)
}

extension VCNavButtons where Self: UIViewController {
    func addBarLeftRightActionsWith(leftBtnTitle: String, rightBtnTitle: String) {
        let rightBarButton = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(self.rightBarButtonPressed(_:)))
        let leftBarButton = UIBarButtonItem(title: leftBtnTitle, style: .plain, target: self, action: #selector(self.leftBarButtonPressed(_:)))
        
        rightBarButton.tintColor = green
        leftBarButton.tintColor = grayColor
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
}
