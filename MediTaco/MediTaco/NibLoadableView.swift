//
//  NibLoadableView.swift
//  MediTaco
//
//  Created by Igor Lantushenko on 06/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
