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
        
        checkNotificationPermissions()
        
        configureNavBar()
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
                result.append(WeekDays(rawValue: day.tag)!)
            }
        }
        
        return result
    }
    
    func setActiveWeekDay(_ active: Bool, withTag: Int) {
        for day in weekDays {
            if day.tag == withTag {
                day.setActive(active)
            }
        }
    }
    
    func configureMealsPicker() {
        pickerView.font = UIFont(name: "AvenirNext-DemiBold", size: 16)!
        pickerView.highlightedFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
        pickerView.highlightedTextColor = UIColor(hex: "E4E0E0")
        pickerView.interitemSpacing = 10
        pickerView.pickerViewStyle = .flat
        pickerView.maskDisabled = true
        pickerView.reloadData()
    }

    func configureNavBar() {
        if let navItem = self.navigationController?.navigationBar.topItem {
            let navBar = navigationController?.navigationBar
            navBar?.isTranslucent = false
            navItem.title = "Day plan"
            UIApplication.shared.statusBarStyle = .lightContent    
        }
    }
    
    func checkNotificationPermissions() {
        /*if !LocalNotificationUtils.isAuthorized() {
            openAppSettings()
        }*/
        
        LocalNotificationUtils.askNotificationPermissions()
    }
    
    func checkFormValidation() {
        var isValid = true

        let weekDays = getActiveWeekDays()
        var validationMessages = ""
        if weekDays.isEmpty {
            isValid = false
            applyDaysLbl.textColor = redColor
            applyDaysLbl.shake()
            validationMessages += " - Please choose at least 1 day from the week\n"
        }
        if DateTimeUtils.isTimeIntervalLess(than: secondsFrom3Hours, betweenDate1: self.sleepAt!, andDate2: self.wakeUpAt!) {
            isValid = false
            sleepAtLbl.textColor = redColor
            sleepAtLbl.shake()
            validationMessages += "- Difference between wake up and sleep at times should be at least 3 hours\n"
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
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
}
