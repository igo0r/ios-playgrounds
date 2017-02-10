//
//  RoundImage.swift
//  roundImage
//
//  Created by Igor Lantushenko on 09/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {

    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 3.0
    }

}
