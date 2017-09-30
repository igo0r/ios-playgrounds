//
//  GeneralModeCell.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 22/09/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class GeneralModeCell: UICollectionViewCell {

    static let identifier = "GeneralModeCell"
    
    @IBOutlet weak var textLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
    }
    
    func configure(withText text: String) {
        textLbl.text = text
    }

}
