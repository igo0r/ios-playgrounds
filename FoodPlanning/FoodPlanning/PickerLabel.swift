//
//  PickerLabel.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 30/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class PickerLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        textColor = whiteColor
        font = fontMedium20
        textAlignment = NSTextAlignment.center
    }

}
