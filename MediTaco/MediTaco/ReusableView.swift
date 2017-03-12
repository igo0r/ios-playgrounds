//
//  ReusableView.swift
//  MediTaco
//
//  Created by Igor Lantushenko on 06/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
