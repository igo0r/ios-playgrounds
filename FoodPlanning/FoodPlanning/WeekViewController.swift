//
//  WeekViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 25/04/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class WeekViewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var weekCalendarBtn: UIButton!
    
    @IBOutlet weak var cleanWeekDatBtn: UIBarButtonItem!
    @IBOutlet weak var timeLine: UIView!
    @IBOutlet var weekDayBtns: [UIButton]!
    
    var weekDay: WeekDay?
    var timeEvents = [TimeEvent]() {
        didSet {
            cleanWeekDatBtn.isEnabled = timeEvents.count > 1
        }
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpinnerView.sharedInstance.showSpinnerFor(view: view)
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.tableFooterView = UIView()
        
        configureNavBar(withTitle: "Meal schedule")
        configureCalendarBtn(weekCalendarBtn)
        
        //LocalNotificationManager.buildLocalNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for btn in weekDayBtns {
            if let weekDayBtn = btn as? WeekDayBtn {
                let btnWeekDay = DateTimeUtils.routeFromDayTagToWeekDays(btnTag: weekDayBtn.tag)
                if  btnWeekDay == defaultDate {
                    weekDayBtn.setButtonActive(true)
                }
            }
        }
        loadDayEventsFor(day: defaultDate)
        SpinnerView.sharedInstance.hideSpinView()
        
        RateApp.showRatePopupOnSuccessPath(forView: self)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        SpinnerView.sharedInstance.hideSpinView()
    }
    
    @IBAction func cleanWeekDayBtnPressed(_ sender: UIBarButtonItem) {
        if let weekDay = weekDay {
            let dayOfWeek = weekDay.weekDay
            AlertUtils.removeWeekDayWithAlert(withTitle: "Delete schedule for \(weekDayNames[dayOfWeek])", message: "Are you sure you want to delete your meal plan for \(weekDayNames[dayOfWeek])", forWeekDay: weekDay, inView: self) { (deleted) in
                if deleted {
                    self.loadDayEventsFor(day: WeekDays(rawValue: dayOfWeek)!)
                }
            }
        }
    }
    
    @IBAction func weekDayBtnPressed(_ sender: WeekDayBtn) {
        SpinnerView.sharedInstance.showSpinnerFor(view: view.superview ?? view)
        
        defaultDate = DateTimeUtils.routeFromDayTagToWeekDays(btnTag: sender.tag)
        
        setInactiveWeekDayBtns()
        sender.setButtonActive(true)
        
        loadDayEventsFor(day: defaultDate)
        SpinnerView.sharedInstance.hideSpinView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = eventsTableView.dequeueReusableCell(withIdentifier: "EventTime", for: indexPath) as? EventTimeTableCell {
            cell.configureCellFor(timeEvent: timeEvents[indexPath.row])
            
            return cell
        }
        
        let cell = EventTimeTableCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        if timeEvents.count == 1 {
            height = 200
        } else {
            height = 70
        }
        
        return height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeEvents.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WeekDayEditor", sender: weekDay)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeekDayEditor" {
            if let nav = segue.destination as? UINavigationController {
                if let destination = nav.childViewControllers[0] as? WeekDayController {
                    if let weekDay = sender as? WeekDay {
                        destination.weekDay = weekDay
                    }
                }
            }
        }
    }
    func loadDayEventsFor(day: WeekDays) {
        RealmManager.loadEventsFor(day: day) { resultDay in
            if let weekDay = resultDay {
                self.timeLine.isHidden = false
                self.weekDay = weekDay
                self.timeEvents = weekDay.prepareTimeEvents()
            } else {
                self.weekDay = WeekDay()
                self.weekDay?.weekDay = day.rawValue
                
                self.timeLine.isHidden = true
                self.timeEvents = [TimeEvent(startAt: Date(), description: "Tap to create your meal plan", notificationDescription: "", weekDay: nil)]
            }
            
            self.eventsTableView.reloadData()
        }
    }
    
    func setInactiveWeekDayBtns() {
        for btn in weekDayBtns {
            if let weekDayBtn = btn as? WeekDayBtn {
                weekDayBtn.setButtonActive(false)
            }
        }

    }
    
    func configureCalendarBtn(_ btn: UIButton) {
        let weekDays = DateTimeUtils.getCurrentWeek()
        let (startWeekDay, endWeekDay) = DateTimeUtils.getWeekStartEndAsWeekDays()
        let start = weekDays[startWeekDay]!
        let end = weekDays[endWeekDay]!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        var weekStr = formatter.string(from: start).uppercased()
        weekStr.append("—\(formatter.string(from: end))  ")
        
        formatter.dateFormat = "MMM yyyy"
        let monthStr = formatter.string(from: start).uppercased()
        
        let weekAttrString = NSMutableAttributedString(
            string: weekStr,
            attributes: [
                NSFontAttributeName: UIFont(name: "AvenirNext-Bold", size: 14)!,
                NSForegroundColorAttributeName: UIColor(hex: "F0554A")
            ]
        )
        let monthStrAttrString = NSMutableAttributedString(
            string: monthStr,
            attributes: [
                NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 14)!,
                NSForegroundColorAttributeName: UIColor(hex: "FCFFFF")            ]
        )
        
        weekAttrString.append(monthStrAttrString)
        btn.setAttributedTitle(weekAttrString, for: .normal)
        btn.sizeToFit()
    }    
}
