//
//  EventCellProtocol.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 25/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit

protocol EventCellProtocol {
    mutating func configureCellFor(cell: EventTableCell, timeEvent: TimeEvent)
}

class EventViewTableCell: EventCellProtocol {

    func configureCellFor(cell: EventTableCell, timeEvent: TimeEvent) {
        cell.setCellProgress(withTimeEvent: timeEvent)
        if timeEvent.weekDay != nil {
            cell.hideCellElements(false)
            cell.timeLbl.text = DateTimeUtils.fromDateToStringUsingCurrentDateFormat(forDate: timeEvent.startAt)
            cell.eventDescriptionLbl.text = timeEvent.description
            cell.notificationDescriptionLbl.text = timeEvent.notificationDescription
        } else {
            cell.hideCellElements(true)
            cell.emptyEventsLbl.text = timeEvent.description
        }

    }
}

class EventEditTableCell: EventCellProtocol {
    /*
     f.e. 01:30 Time to drink water
     */
    func configureCellFor(cell: EventTableCell, timeEvent: TimeEvent) {
        cell.setCellProgress(withTimeEvent: timeEvent)
        if timeEvent.weekDay != nil {
            cell.hideCellElements(false)
            cell.timeLbl.text = DateTimeUtils.fromDateToStringUsingCurrentDateFormat(forDate: timeEvent.startAt)
            cell.eventDescriptionLbl.text = timeEvent.description
            cell.progressDone.isHidden = false
            cell.progressDone.image = UIImage(named: "Disclosure Indicator")
            cell.progressDone.contentMode = .scaleAspectFit
            cell.notificationDescriptionLbl.text = timeEvent.notificationDescription
        } else {
            cell.hideCellElements(true)
            cell.emptyEventsLbl.text = timeEvent.description
        }
    }
}
