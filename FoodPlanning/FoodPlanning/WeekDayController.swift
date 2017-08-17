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
    
    @IBOutlet weak var tipToEditLbl: TipLabel!
    @IBOutlet weak var wakeUpPicker: CustomDatePicker!
    @IBOutlet weak var sleepTimePicker: CustomDatePicker!
    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var applyDaysLbl: UILabel!
    @IBOutlet weak var sleepAtLbl: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    //Validation lbls
    @IBOutlet weak var validationSleepLbl: UILabel!
    @IBOutlet weak var validationWeekDaySLbl: UILabel!
    
    @IBOutlet var weekDays: [WeekDayFormBtn]!
    
    var waterForm = WeekDayWaterForm()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpinnerView.sharedInstance.showSpinnerFor(view: view)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        configureNavBar(withTitle: "Day plan. Step 1")
        configureView()
        configureDayForm()
        configureTips()
        let selectedItem = mealsCountArr.index(of: mealsCount!)!
        pickerView.selectItem(selectedItem, animated: false, notifySelection: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        waterForm.updateWaterForm = true
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
            UserDefaultsUtils.increaseSuccessPath()
            dismiss(animated: true, completion: nil)
        } else {
            checkFormValidation()
        }
        SpinnerView.sharedInstance.hideSpinView()
    }
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return mealsCountArr.count
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return "\(mealsCountArr[item])"
    }
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        mealsCount = mealsCountArr[item]
        waterForm.updateWaterForm = true
    }
    
    /*
     set data for all the fields
     */
    func configureDayForm() {
        if let day = weekDay {
            setActiveWeekDay(true, withTag: day.weekDay)
            mealsCount = day.mealsCount
            wakeUpAt = day.getWakeUpAt()
            sleepAt = day.getSleepAt()
        } else {
            waterForm.updateWaterForm = true
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
    
    func configureTips() {
        if let timeEvents = waterForm.getTimeEvents() {
            if timeEvents.count > 0 {
                tipToEditLbl.shakeVertical()
            } else {
                tipToEditLbl.isHidden = true
            }
        }
    }
    
    func configureMealsPicker() {
        pickerView.font = fontDemiBold17
        pickerView.highlightedFont = fontDemiBold18
        pickerView.highlightedTextColor = white
        pickerView.interitemSpacing = 14
        pickerView.pickerViewStyle = .flat
        pickerView.maskDisabled = true
        pickerView.reloadData()
    }
    
    func checkFormValidation() {
        var isValid = true

        let weekDays = getActiveWeekDays()
        if weekDays.isEmpty {
            isValid = false
            applyDaysLbl.textColor = redColor
            applyDaysLbl.shake()
        }
        if DateTimeUtils.isTimeIntervalLess(than: secondsFrom3Hours, betweenDate1: self.sleepAt!, andDate2: self.wakeUpAt!) {
            isValid = false
            sleepAtLbl.textColor = redColor
            sleepAtLbl.shake()
        }
        
        if isValid {
            guard let waterVC = storyboard?.instantiateViewController(withIdentifier: WaterViewController.storyboardID) else {
                print("View controller WaterViewController.storyboardID not found")
                return
            }
            if let vc = waterVC as? WaterViewController {
                waterForm.setWeekDays(prepareWeekDayArrayWith(weekDays: weekDays))
                vc.waterForm = waterForm
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
