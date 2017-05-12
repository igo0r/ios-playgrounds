//
//  EventTimeTableCellTableViewCell.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 04/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class EventTimeTableCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var eventDescriptionLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCellFor(timeEvent: TimeEvent) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        timeLbl.text =  formatter.string(from: timeEvent.startAt)
        eventDescriptionLbl.text = timeEvent.description
    }
}
