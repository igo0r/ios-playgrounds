//
//  SettingViewControllerTableViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 04/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
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
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
