//
//  ItemCellTableViewCell.swift
//  DreamList
//
//  Created by Igor Lantushenko on 12/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var detailsView: UILabel!
    @IBOutlet weak var priceView: UILabel!
    
    func configureCell(item: Item){
        nameView.text = item.title
        priceView.text = String(item.price)
        detailsView.text = item.details
        thumbView.image = item.toImage != nil ? item.toImage!.image as! UIImage : UIImage()
    }
}
