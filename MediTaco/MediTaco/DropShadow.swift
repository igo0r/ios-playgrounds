//
//  DropShadow.swift
//  MediTaco
//
//  Created by Igor Lantushenko on 06/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

protocol DropShadow {}

extension DropShadow where Self: UIView {
    func addDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize.zero
    }
}
