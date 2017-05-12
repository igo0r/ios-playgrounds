//
//  ViewController.swift
//  UIViewHomeWork
//
//  Created by Igor Lantushenko on 09/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIViewUtils.buildRectanglesInOneRawWith(count: 10, forView: self.view)
        //UIViewUtils.buildRectanglesInMultipleRaws(withCentering: false, forCount: 10, inView: self.view)
        //UIViewUtils.buildRectanglesInMultipleRaws(withCentering: true, forCount: 3, inView: self.view)
        UIViewUtils.buildCircleTargetWith(count: 10, inView: self.view)
    }
}

