//
//  EventTimeTableCellTableViewCell.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 04/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class EventTableCell: UITableViewCell {
    
    var delegation: EventCellProtocol?
    
    @IBOutlet weak var smallClock: UIImageView!
    @IBOutlet weak var timeLineView: UIView!
    @IBOutlet weak var notificationDescriptionLbl: UILabel!
    //progress
    @IBOutlet weak var progreeTime: UILabel!
    @IBOutlet weak var progressDone: UIImageView!
    
    @IBOutlet weak var leadingTimeLblConstr: NSLayoutConstraint!
    
    //@IBOutlet weak var progressView: UIView!
    @IBOutlet weak var clockView: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var eventDescriptionLbl: UILabel!
    @IBOutlet weak var ovalCircle: UIImageView!
    @IBOutlet weak var emptyEventsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        separatorInset = .zero
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellFor(timeEvent: TimeEvent)
    {
        delegation?.configureCellFor(cell: self, timeEvent: timeEvent)
    }
    
    /*
     set progress from 0 to 1
     */
    func setCellProgress(withTimeEvent timeEvent: TimeEvent) {
        let progressTime = timeEvent.progressTime
        if progressTime == 0 {
            progressDone.isHidden = true
            progreeTime.isHidden = true
        } else if progressTime == progressViewMaxValue {
            progressDone.isHidden = false
            progreeTime.isHidden = true
        } else {
            progressDone.isHidden = true
            progreeTime.isHidden = false
            progreeTime.text = DateTimeUtils.convertToHoursMinsFrom(seconds: progressTime)
        }
    }
    
    func hideCellElements(_ hide: Bool) {
        timeLbl.isHidden = hide
        eventDescriptionLbl.isHidden = hide
        ovalCircle.isHidden = hide
        notificationDescriptionLbl.isHidden = hide
        timeLineView.isHidden = hide
        smallClock.isHidden = hide
        
        
        emptyEventsLbl.isHidden = !hide
        clockView.isHidden = !hide
    }
}
