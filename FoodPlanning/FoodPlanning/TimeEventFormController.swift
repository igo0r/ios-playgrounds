//
//  TimeEventFormController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 26/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class TimeEventFormController: UIViewController, UITextViewDelegate, UITextFieldDelegate, NavigationBarActionProtocol {

    @IBOutlet weak var timeEventValidationLbl: FormValidationLabel!
    @IBOutlet weak var eventTitleTextField: FormTextField!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet weak var eventTimeDatePicker: CustomDatePicker!
    
    private var timeEvent: TimeEvent?
    private var timeEventIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventDescriptionTextView.delegate = self
        eventTitleTextField.delegate = self
        
        configureView()
        configureNavBar(withTitle: timeEvent?.description ?? "Edit event")
        configureForm()
        
        hideKeyboardWhenTappedAround()
        addBarLeftRightActionsWith(leftBtnStyle: .cancel, rightBtnStyle: .save)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        eventTitleTextField.setAttributedPlaceholder(withText: "E.g. breakfast, lunch, sneak...")
        _ = isTimeEventFormValid()
    }
    
    func saveBarButtonPressed(_ sender: UIBarButtonItem!) {
        if (!isTimeEventFormValid()) {
            return
        }
        
        updateTimeEventFromForm()
        if let vc = getPreviousControllerFromNav() as? EventViewUpdateProtocol {
            if timeEvent != nil && timeEventIndex != nil {
                vc.updateTimeEventFrom(formTimeEventData: (timeEventIndex!, timeEvent!))
                _ = navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func cancelBarButtonPressed(_ sender: UIBarButtonItem!) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // hides text views
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        let maxCharacter: Int = 120
        return (textView.text?.utf16.count ?? 0) + text.utf16.count - range.length <= maxCharacter
    }
    
    // hides text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        
        let maxCharacter: Int = 24
        return (textField.text?.utf16.count ?? 0) + string.utf16.count - range.length <= maxCharacter
    }
    
    @IBAction func mealNameEditingDidEnd(_ sender: UITextField) {
        _ = isTimeEventFormValid()
    }
    
    @IBAction func eventTimePickerValueChanged(_ sender: CustomDatePicker) {
        _ = isTimeEventFormValid()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
    }
    
    func setTimeEvent(data timeEventData: (Int,TimeEvent)) {
        self.timeEventIndex = timeEventData.0
        self.timeEvent = timeEventData.1
    }
    
    func updateTimeEventFromForm() {
        if timeEvent != nil {
            timeEvent?.startAt = eventTimeDatePicker.date
            timeEvent?.description = eventTitleTextField.text ?? ""
            timeEvent?.notificationDescription = eventDescriptionTextView.text ?? ""
        }
    }
    
    func isTimeEventFormValid() -> Bool {
        var isValid = true
        if eventTitleTextField.text?.characters.count == 0 {
            eventTitleTextField.shake()
            isValid = false
        }
        if !isValidEventTime() {
            if let weekDay = timeEvent?.weekDay {
                let wakeUpAt = DateTimeUtils.fromDateToStringUsingCurrentDateFormat(forDate: weekDay.getWakeUpAt())
                let sleepAt = DateTimeUtils.fromDateToStringUsingCurrentDateFormat(forDate: weekDay.getSleepAt())
                
                timeEventValidationLbl.text = "Meal time should be between \(wakeUpAt) and \(sleepAt)"
                timeEventValidationLbl.isValid = false
            }
        
            eventTimeDatePicker.shake()
            isValid = false
        } else {
            timeEventValidationLbl.isValid = true
        }
        
        return isValid
    }
    
    func isValidEventTime() -> Bool {
        if let weekDay = timeEvent?.weekDay {
            return eventTimeDatePicker.date <= weekDay.getSleepAt() && eventTimeDatePicker.date >= weekDay.getWakeUpAt()
        }
        
        return true
    }
    
    func configureForm() {
        eventTitleTextField.text = self.timeEvent?.description ?? ""
        eventDescriptionTextView.text = self.timeEvent?.notificationDescription ?? ""
        eventTimeDatePicker.date = self.timeEvent?.startAt ?? DateTimeUtils.now
        
        eventDescriptionTextView.backgroundColor = black
        eventDescriptionTextView.textColor = white
        eventDescriptionTextView.font = fontMedium15
    }
}
