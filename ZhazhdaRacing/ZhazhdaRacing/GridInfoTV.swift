//
//  GridInfoTV.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 28/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class GridInfoTV: UITableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        allowsSelection = false
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
