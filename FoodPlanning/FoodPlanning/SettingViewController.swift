//
//  SettingViewControllerTableViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 04/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var waterTimerPicker: UIPickerView!
    
    @IBOutlet weak var notificationSwitcher: UISwitch!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        waterTimerPicker.dataSource = self
        waterTimerPicker.delegate = self
        
        configureNavBar(withTitle: "Settings")
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        waterTimerPicker.selectRow(waterTimeRange.index(of: UserDefaultsUtils.getWaterTime()) ?? 30, inComponent: 0, animated: true)
        saveBtn.isEnabled = false
        LocalNotificationUtils.isAuthorizedToSendNotifications() { (isAuth) in
            self.notificationSwitcher.setOn(isAuth, animated: true)
        }
    }

    @IBAction func notificationSwitchAction(_ sender: UISwitch) {
        enableLocalNotifications(sender.isOn) { sender.setOn($0, animated: true) }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let row = waterTimerPicker.selectedRow(inComponent: 0)
        
        UserDefaultsUtils.setWaterTime(minutes:  waterTimeRange[row])
        
        BackgroundTaskTracker.requestToUpdateNotifications()
        
        saveBtn.isEnabled = false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        } else if indexPath.row == 3 {
            RateApp.rateApp() { (success) in
                
            }
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
    
    func willEnterForeground() {
        print("Enter foreground")
        LocalNotificationUtils.isAuthorizedToSendNotifications() { (isAuth) in
            self.notificationSwitcher.setOn(isAuth, animated: true)
        }
    }
    
    func configureView() {
        waterTimerPicker.backgroundColor = black
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "lemons")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = black
        backgroundImage.addSubview(backgroundView)
        view.insertSubview(backgroundImage, at: 0)
    }
}
