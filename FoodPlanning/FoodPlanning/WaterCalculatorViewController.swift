//
//  WaterCalculatorViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 05/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class WaterCalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let waterKgRange = Array(10...250)
    let waterLbsRange = Array(22...551)
    
    let waterGramsRange = Array(200...5000)
    let waterOzRange = Array(7...175)
    
    
    let dayActivityRange = ["Sedentary", "Light", "Moderately", "Hard", "Extremely hard"]
    let dayActivityBridge: [Activity] = [.Sedentary, .Light, .Moderately, .Hard, .ExtremelyHard]
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    @IBOutlet weak var minWaterValueLbl: UILabel!
    @IBOutlet weak var maxWaterValueLbl: UILabel!
    
    @IBOutlet weak var waterQuantityMeasure: UILabel!
    @IBOutlet weak var waterQuantityLbl: UILabel!
    
    @IBOutlet weak var waterQuantitySlider: UISlider!
    @IBOutlet weak var dayActivitySwitcher: UIPickerView!
    @IBOutlet weak var weightSwitcher: UIPickerView!
    @IBOutlet weak var metricSwitcher: UISegmentedControl!
    
    var waterCalculator = WaterCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar(withTitle: "Water calculator")
        configureView()
        
        weightSwitcher.backgroundColor = black
        dayActivitySwitcher.backgroundColor = black
        weightSwitcher.dataSource = self
        weightSwitcher.delegate = self
        dayActivitySwitcher.dataSource = self
        dayActivitySwitcher.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateWaterElements()
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func metricSwitched(_ sender: UISegmentedControl) {
        waterCalculator.isCurrentSystemMetric = sender.selectedSegmentIndex == 0 ? false : true
        updateWaterElements()
    }
    
    @IBAction func waterQuantityChanged(_ sender: UISlider) {
        waterCalculator.waterQuantity = Double(sender.value)
        updateWaterElements()
    }
    
    @IBAction func estimationBtnPressed(_ sender: UIButton) {
        waterCalculator.calculateWaterQuantity()
        updateWaterElements()
    }
    
    // MARK: - Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 {
            return 2
        } else {
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return component == 0 ? getCurrentWeightRange().count : 1
        } else {
            return dayActivityRange.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = whiteColor
        if pickerView.tag == 0 {
            pickerLabel.text = component == 0 ? "\(getCurrentWeightRange()[row])" : waterCalculator.getWeightLblTxt()
        } else {
            pickerLabel.text = dayActivityRange[row]
        }
        
        pickerLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)!
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            waterCalculator.weight = Double(getCurrentWeightRange()[row])
        } else {
            waterCalculator.activity = dayActivityBridge[row]
        }
        
    }

    func updateWaterElements() {
        metricSwitcher.selectedSegmentIndex = waterCalculator.isCurrentSystemMetric ? 1 : 0
        
        let waterQuantity = waterCalculator.waterQuantity
        waterQuantityMeasure.text = waterCalculator.getWaterLblTxt()
        waterQuantityLbl.text = "\(Int(waterQuantity))"
        
        let waterRange = getCurrentWaterRange()
        waterQuantitySlider.minimumValue = Float(waterRange[0])
        waterQuantitySlider.maximumValue = Float(waterRange[waterRange.count - 1])
        minWaterValueLbl.text = "\(waterRange[0])"
        maxWaterValueLbl.text = "\(waterRange[waterRange.count - 1])"
        
        waterQuantitySlider.value = Float(waterQuantity)
        
        weightSwitcher.setNeedsLayout()
        
        weightSwitcher.selectRow(getCurrentWeightRange().index(of: Int(waterCalculator.weight)) ?? 0, inComponent: 0, animated: true)
        dayActivitySwitcher.selectRow(getCurrentActivityIndex(), inComponent: 0, animated: true)
    }
    
    func getCurrentWaterRange() -> [Int] {
        return waterCalculator.isCurrentSystemMetric ? waterGramsRange : waterOzRange
    }
    
    func getCurrentWeightRange() -> [Int] {
        return waterCalculator.isCurrentSystemMetric ? waterKgRange : waterLbsRange
    }
    
    func getCurrentActivityIndex() -> Int {
        return dayActivityBridge.index(of: waterCalculator.activity) ?? 0
    }
}
