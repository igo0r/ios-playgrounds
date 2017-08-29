//
//  NavControllerExt.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 28/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension UINavigationController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return visibleViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override open var shouldAutorotate: Bool {
        return visibleViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
}
