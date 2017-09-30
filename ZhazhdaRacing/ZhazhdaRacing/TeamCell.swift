//
//  TeamCellTableViewCell.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 24/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {

    static let name = "TeamCell"
    static let identifier = "GridInfo"
    
    @IBOutlet weak var rightLbl: GridCellLabel!
    @IBOutlet weak var leftLbl: GridCellLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        layoutMargins = .zero //or UIEdgeInsetsMake(top, left, bottom, right)
        separatorInset = .zero
    }
    
    func configureCellFor(gridInfo: GridInfo) {
        rightLbl.text = gridInfo.value
        leftLbl.text = gridInfo.name
    }
}
