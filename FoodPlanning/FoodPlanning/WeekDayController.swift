//
//  FoodTimingController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 29/04/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import UserNotifications

class WeekDayController: UIViewController, UINavigationControllerDelegate, AKPickerViewDelegate, AKPickerViewDataSource {

    @IBOutlet weak var wakeUpPicker: CustomDatePicker!
    @IBOutlet weak var sleepTimePicker: CustomDatePicker!
    @IBOutlet weak var waterBtn: UIButton!
    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var applyDaysLbl: UILabel!
    @IBOutlet weak var sleepAtLbl: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var waterMinutesLbl: UILabel!
    
    //Validation lbls
    @IBOutlet weak var validationSleepLbl: UILabel!
    @IBOutlet weak var validationWeekDaySLbl: UILabel!
    
    @IBOutlet var weekDays: [WeekDayFormBtn]!
    
    var weekDay: WeekDay?
    var mealsCount: Int?
    var wakeUpAt: Date? {
        didSet {
            wakeUpPicker.date = wakeUpAt!
            _ = isFormValid()
        }
    }
    var sleepAt: Date? {
        didSet {
            sleepTimePicker.date = sleepAt!
            _ = isFormValid()
        }
    }
    
    var isSleepChanged = false
    var withWater = false {
        didSet {
            if withWater {
                waterBtn.setImage(UIImage(named: "Check"), for: .normal)
            } else {
                waterBtn.setImage(nil, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpinnerView.sharedInstance.showSpinnerFor(view: view)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        configureNavBar(withTitle: "Day plan")
        configureDayForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let selectedItem = mealsCountArr.index(of: mealsCount!)!
        pickerView.selectItem(selectedItem, animated: true)
        _ = isFormValid()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SpinnerView.sharedInstance.hideSpinView()
    }
    
    @IBAction func timeChangedAction(_ sender: CustomDatePicker) {
        let date = sender.date
        if sender.tag == 0 {
            wakeUpAt = date
            if !isSleepChanged && DateTimeUtils.isTimeIntervalLess(than: secondsFrom3Hours, betweenDate1: sleepAt!, andDate2: wakeUpAt!) {
                sleepAt = wakeUpAt!.addingTimeIntervalNotBiggerThanTomorrow(secondsFrom13Hours)
            }
        } else {
            isSleepChanged = true
            sleepAt = date
        }
    }
    
    @IBAction func weekDayBtnPressed(_ sender: WeekDayFormBtn) {
        sender.setActive(!sender.isActiveWeekDay)
        _ = isFormValid()
    }
    
    @IBAction func daysApplyBtnPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            setActiveWeekDays(false)
        } else {
            setActiveWeekDays(true)
        }
        _ = isFormValid()
    }
    
    @IBAction func navBarBtnPressed(_ sender: UIBarButtonItem) {
        SpinnerView.sharedInstance.showSpinnerFor(view: view)
        if sender.tag == 0 {
            dismiss(animated: true, completion: nil)
        } else {
            checkFormValidation()
        }
        SpinnerView.sharedInstance.hideSpinView()
    }
    
    @IBAction func waterBtnPressed(_ sender: UIButton) {
        withWater = !withWater
    }
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return mealsCountArr.count
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return "\(mealsCountArr[item])"
    }
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        mealsCount = mealsCountArr[item]
    }
    
    func configureDayForm() {
        if let day = weekDay {
            setActiveWeekDay(true, withTag: day.weekDay)
            withWater = day.withWater
            mealsCount = day.mealsCount
            wakeUpAt = day.getWakeUpAt()
            sleepAt = day.getSleepAt()
        }
        waterMinutesLbl.text = "\(UserDefaultsUtils.getWaterTime()) minutes before meal. Change it in settings"
        configureMealsPicker()
    }
    
    func setActiveWeekDays(_ active: Bool) {
        for day in weekDays {
            day.setActive(active)
        }
    }
    
    func getActiveWeekDays() -> [WeekDays]{
        var result = [WeekDays]()
        for day in weekDays {
            if day.isActiveWeekDay {
                let btnWeekDay = DateTimeUtils.routeFromDayTagToWeekDays(btnTag: day.tag)
                result.append(btnWeekDay)
            }
        }
        
        return result
    }
    
    func setActiveWeekDay(_ active: Bool, withTag: Int) {
        for day in weekDays {
            let btnWeekDay = DateTimeUtils.routeFromDayTagToWeekDays(btnTag: day.tag)
            if btnWeekDay.rawValue == withTag {
                day.setActive(active)
            }
        }
    }
    
    func configureMealsPicker() {
        pickerView.font = UIFont(name: "AvenirNext-DemiBold", size: 17)!
        pickerView.highlightedFont = UIFont(name: "AvenirNext-DemiBold", size: 18)!
        pickerView.highlightedTextColor = UIColor(hex: "E4E0E0")
        pickerView.interitemSpacing = 14
        pickerView.pickerViewStyle = .flat
        pickerView.maskDisabled = true
        pickerView.reloadData()
    }
    
    func checkFormValidation() {
        var isValid = true

        let weekDays = getActiveWeekDays()
        var validationMessages = ""
        if weekDays.isEmpty {
            isValid = false
            applyDaysLbl.textColor = redColor
            applyDaysLbl.shake()
            validationMessages += " - At least 1 day from the week should be chosen\n"
        }
        if DateTimeUtils.isTimeIntervalLess(than: secondsFrom3Hours, betweenDate1: self.sleepAt!, andDate2: self.wakeUpAt!) {
            isValid = false
            sleepAtLbl.textColor = redColor
            sleepAtLbl.shake()
            validationMessages += "- Wake up and sleep at times should differs for 3 hours at least\n"
        }
        
        if !isValid {
            let alert = UIAlertController(title: "Validation failed", message: validationMessages, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
        } else {            
            for day in weekDays {
                let weekDay = WeekDay()
                weekDay.mealsCount = mealsCount!
                weekDay.sleepAt = self.sleepAt! as NSDate
                weekDay.wakeUpAt = self.wakeUpAt! as NSDate
                weekDay.weekDay = day.hashValue
                weekDay.withWater = self.withWater
                
                RealmManager.writeWeekDay(obj: weekDay)
            }
            
            //LocalNotificationManager.buildLocalNotifications()
            BackgroundTaskTracker.requestToUpdateNotifications()
            
            //if let alert = askNotificationPermissionsIfNeeded(withDismiss: true) {
            askNotificationPermissionsIfNeeded(withDismiss: true) { (alert) in
                if let alert = alert {
                    self.present(alert, animated: true, completion: nil)
                } else {
                self.dismiss(animated: true, completion: nil)
                }
            }
            UserDefaultsUtils.increasSavePlanCounter()
            UserDefaultsUtils.increaseSuccessPath()
        }
    }
}
