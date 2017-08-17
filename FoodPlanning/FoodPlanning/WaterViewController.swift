//
//  WaterViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 27/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class WaterViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    static let storyboardID = "WaterController"
    
    @IBOutlet weak var waterSwitcher: UISwitch!
    @IBOutlet weak var waterTimerPicker: UIPickerView!
    
    @IBOutlet weak var waterQuantityLbl: UILabel!
    
    var waterForm: DefaultWaterForm = WaterForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        waterTimerPicker.backgroundColor = black
        configureView()
        
        waterTimerPicker.dataSource = self
        waterTimerPicker.delegate = self
        
        configureNavBar(withTitle: waterForm.getNavBarTitle())
        configureNavBarButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        waterQuantityLbl.text = "\(Int(waterForm.waterCalculator.waterQuantity)) \(waterForm.waterCalculator.getWaterLblTxt())"
        waterSwitcher.isOn = waterForm.isWaterOn
        waterTimerPicker.selectRow(waterTimeRange.index(of: waterForm.waterTime) ?? 30, inComponent: 0, animated: true)
    }

    @IBAction func waterSwitcherPressed(_ sender: UISwitch) {
        waterForm.isWaterOn = sender.isOn
        waterForm.updateWaterForm = true
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
            waterForm.updateWaterForm = true
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
        
        let pickerLabel = PickerLabel()
        pickerLabel.text = component == 0 ? "\(waterTimeRange[row])" : "min"
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        waterForm.waterTime = waterTimeRange[row]
        waterForm.updateWaterForm = true
    }
    
    func setWaterForm(waterForm: DefaultWaterForm) {
        self.waterForm = waterForm
    }
    
    private func configureNavBarButtons() {
        switch waterForm.getWaterFormCondition() {
        case .WaterTemplateView:
            setupStandAloneBarButtons()
        case .WaterWeekDayView:
            setupeWeekDayBarButtons()
        }
    }
}
