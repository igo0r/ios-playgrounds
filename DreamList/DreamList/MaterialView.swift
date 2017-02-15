//
//  MaterialView.swift
//  DreamList
//
//  Created by Igor Lantushenko on 12/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {

    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        } set {
            materialKey = newValue
            if materialKey {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 3.0
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
        
    }

}
