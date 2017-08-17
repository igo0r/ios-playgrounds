//
//  TimeEventViewExt.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 05/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension TimeEventViewController: NavigationBarActionProtocol {
    func configureTimeEventView(withWaterForm waterForm: WeekDayWaterForm) {
        if waterForm.shouldBeUpdated() {
            if let weekDays = waterForm.getWeekDays() {
                if weekDays.count > 0 {
                    let timeEvents = weekDays[0].prepareTimeEvents()
                    waterForm.setTimeEvents(timeEvents)
                    waterForm.updateWaterForm = false
                }
            }
        }
        
        self.timeEvents = waterForm.getTimeEvents() ?? []
        self.waterForm = waterForm
    }
    
    func saveBarButtonPressed(_ sender: UIBarButtonItem!) {
        updateWaterFormBeforeLeave()
        askNotificationPermissionsIfNeeded(withDismiss: true) { (alert) in
            if let alert = alert {
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        UserDefaultsUtils.increasSavePlanCounter()
        UserDefaultsUtils.increaseSuccessPath()
        if let weekDays = waterForm?.getWeekDays() {
            _ = weekDays.map { (weekDay) in
                WeekDayRealmManager.writeWeekDay(obj: weekDay)
                TimeEventRealmManager.writeTimeEvents(objs: timeEvents.map { (timeEvent) -> TimeEvent in
                    var tE = timeEvent
                    tE.weekDay = weekDay
        
                    return tE
                })
            }
            
        }
        BackgroundTaskTracker.requestToUpdateNotifications()
    }
    
    func cancelBarButtonPressed(_ sender: UIBarButtonItem!) {
        updateWaterFormBeforeLeave()
        goToPreviousViewController()
    }
    
    func updateTimeEventFrom(formTimeEventData: (Int, TimeEvent)) {
        timeEvents[formTimeEventData.0] = formTimeEventData.1
        timeEvents.sort(by: {$0.startAt < $1.startAt})
        
        tableView.reloadData()
        refreshTableCellsHeight()
    }
    
    private func updateWaterFormBeforeLeave() {
        if waterForm != nil {
            waterForm?.setTimeEvents(timeEvents)
        }
    }
    
    func setupeWeekDayBarButtons() {
        addBarLeftRightActionsWith(leftBtnTitle: "Back", rightBtnTitle: "Save")
    }
    
    func goToPreviousViewController() {
        if let vc = self.getPreviousControllerFromNav() as? WaterViewController {
            if self.waterForm != nil {
                vc.waterForm = self.waterForm!
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
