//
//  WaterViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 27/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class WaterViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var waterSwitcher: UISwitch!
    @IBOutlet weak var waterTimerPicker: UIPickerView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    @IBOutlet weak var waterQuantityLbl: UILabel!
    var waterCalculator = WaterCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        waterTimerPicker.backgroundColor = black
        configureView()
        
        waterTimerPicker.dataSource = self
        waterTimerPicker.delegate = self
        
        configureNavBar(withTitle: "Water")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        saveBtn.isEnabled = false
        
        waterQuantityLbl.text = "\(Int(waterCalculator.waterQuantity)) \(waterCalculator.getWaterLblTxt())"
        waterSwitcher.isOn = UserDefaultsUtils.getWaterBeforeMeal()
        waterTimerPicker.selectRow(waterTimeRange.index(of: UserDefaultsUtils.getWaterTime()) ?? 30, inComponent: 0, animated: true)
    }

    @IBAction func waterSwitcherPressed(_ sender: UISwitch) {
        saveBtn.isEnabled = true
        UserDefaultsUtils.setWaterBeforeMeal(include: sender.isOn)
    }
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        let row = waterTimerPicker.selectedRow(inComponent: 0)
        
        UserDefaultsUtils.setWaterTime(minutes:  waterTimeRange[row])
        UserDefaultsUtils.setWaterBeforeMeal(include: waterSwitcher.isOn)
        
        BackgroundTaskTracker.requestToUpdateNotifications()
        saveBtn.isEnabled = false
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 2
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            performSegue(withIdentifier: "WaterCalculation", sender: nil)
        }
    }
    
    // MARK: - Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? waterTimeRange.count : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = whiteColor
        pickerLabel.text = component == 0 ? "\(waterTimeRange[row])" : "min"
        pickerLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)!
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        saveBtn.isEnabled = true
    }
}
