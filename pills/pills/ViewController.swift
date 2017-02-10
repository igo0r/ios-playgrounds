//
//  ViewController.swift
//  pills
//
//  Created by Igor Lantushenko on 28/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var successImageView: UIImageView!
    
    @IBOutlet weak var statePickerView: UIPickerView!
    @IBOutlet weak var pickBtnView: UIButton!
    
    @IBOutlet weak var countryLabelView: UILabel!
    @IBOutlet weak var countryTextView: UITextField!
    
    @IBOutlet weak var zipLabelView: UILabel!
    @IBOutlet weak var zipTextView: UITextField!
    
    
    let states = ["Kiev", "Sumy", "Kharkiv", "Odessa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statePickerView.delegate = self
        statePickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stateBtnPressed(_ sender: Any) {
        statePickerView.isHidden = false
        
        countryLabelView.isHidden = true
        countryTextView.isHidden = true
        
        zipLabelView.isHidden = true
        zipTextView.isHidden = true
    }
    
    @IBAction func buyBtnAction(_ sender: Any) {
        successImageView.isHidden = false
        
        for view in self.view.subviews {
            if (view.restorationIdentifier == "successImage") {
                continue
            }
            view.isHidden = true
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickBtnView.setTitle(states[row], for: UIControlState.normal)
        pickerView.isHidden = true
        
        countryLabelView.isHidden = false
        countryTextView.isHidden = false
        
        zipLabelView.isHidden = false
        zipTextView.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
}

