//
//  ArrayExt.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 01/09/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension Array{
    subscript(path: IndexPath) -> Element {
        return self[path.row]
    }
}
