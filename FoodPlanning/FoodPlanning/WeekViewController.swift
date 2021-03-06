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
    @IBOutlet var weekDayBtns: [UIButton]!
    
    var reloadTableDataTimer: Timer?
    var weekDay: WeekDay?
    var timeEvents = [TimeEvent]() {
        didSet {
            cleanWeekDatBtn.isEnabled = timeEvents.count > 1
        }
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpinnerView.sharedInstance.showSpinnerFor(view: view)
        
        eventsTableView.register(UINib(nibName: "EventTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CellTable")
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.tableFooterView = UIView()
        
        DateTimeUtils.updateCurrentDateKey()
        
        configureNavBar(withTitle: "Meal schedule")
        configureView()
        
        configureCalendarBtn(weekCalendarBtn)
        
        NotificationCenter.default.addObserver(self, selector: #selector(WeekViewVC.refreshWeekViewData), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil )
        
        reloadTableDataTimer = Timer(timeInterval: 60.0, target: self, selector: #selector(WeekViewVC.refreshWeekViewData), userInfo: nil, repeats: true)
        RunLoop.main.add(self.reloadTableDataTimer!, forMode: RunLoopMode.defaultRunLoopMode)
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
        loadDayEventsFor(day: defaultDate, withProgress: true)
        SpinnerView.sharedInstance.hideSpinView()
        
        RateApp.showRatePopupOnSuccessPath(forView: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        SpinnerView.sharedInstance.hideSpinView()
    }
    
    @IBAction func editWeekDayBtnPressed(_ sender: UIBarButtonItem) {
        if let weekDay = weekDay {
            performSegue(withIdentifier: "WeekDayEditor", sender: weekDay)
        }
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
        
        loadDayEventsFor(day: defaultDate, withProgress: true)
        SpinnerView.sharedInstance.hideSpinView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = eventsTableView.dequeueReusableCell(withIdentifier: "CellTable", for: indexPath) as? EventTableCell {
            cell.delegation = EventViewTableCell()
            cell.configureCellFor(timeEvent: timeEvents[indexPath.row])
            
            return cell
        }
        
        let cell = EventTableCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
                        let waterForm = WeekDayWaterForm()
                        waterForm.setTimeEvents(TimeEventRealmManager.loadTimeEventsFor(weekDay: weekDay))
                        destination.weekDay = weekDay
                        destination.waterForm = waterForm
                    }
                }
            }
        }
    }
    
    func loadDayEventsFor(day: WeekDays, withProgress: Bool = false, withUpdatingCellHeight: Bool = true) {
        WeekDayRealmManager.loadEventsFor(day: day) { resultDay in
            if let weekDay = resultDay {
                self.weekDay = weekDay
                self.timeEvents = weekDay.prepareEvents(withProgress)
            } else {
                self.weekDay = WeekDay()
                self.weekDay?.weekDay = day.rawValue
                
                self.timeEvents = [TimeEvent(startAt: Date(), description: "Tap to create your meal plan", notificationDescription: "", weekDay: nil)]
            }
            
            self.eventsTableView.reloadData()
            if withUpdatingCellHeight {
                self.refreshTableCellsHeight()
            }
        }
    }
    
    func setInactiveWeekDayBtns() {
        for btn in weekDayBtns {
            if let weekDayBtn = btn as? WeekDayBtn {
                weekDayBtn.setButtonActive(false)
            }
        }

    }
    
    /*
     compose string
     f.e. 01-07 November 2017
     */
    func configureCalendarBtn(_ btn: UIButton) {
        let weekDays = DateTimeUtils.getCurrentWeek()
        let (startWeekDay, endWeekDay) = DateTimeUtils.getWeekStartEndAsWeekDays()
        let start = weekDays[startWeekDay]!
        let end = weekDays[endWeekDay]!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        var weekStr = formatter.string(from: start).uppercased()
        weekStr.append("—\(formatter.string(from: end))  ")
        
        formatter.dateFormat = "MMM yyyy"
        let monthStr = formatter.string(from: start).uppercased()
        
        let weekAttrString = NSMutableAttributedString(
            string: weekStr,
            attributes: [
                NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 14)!,
                NSAttributedStringKey.foregroundColor: UIColor(hex: "F0554A")
            ]
        )
        let monthStrAttrString = NSMutableAttributedString(
            string: monthStr,
            attributes: [
                NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 14)!,
                NSAttributedStringKey.foregroundColor: UIColor(hex: "FCFFFF")            ]
        )
        
        weekAttrString.append(monthStrAttrString)
        btn.setAttributedTitle(weekAttrString, for: .normal)
    }
    
    func refreshTableCellsHeight() {
        eventsTableView.beginUpdates()
        eventsTableView.endUpdates()
    }
    
    /*
     when page opens too long - progress needs to be updated
     */
    @objc func refreshWeekViewData() {
        if !DateTimeUtils.isCurrentDateKeyValid() {
            DateTimeUtils.currentWeek = [:]
            configureCalendarBtn(weekCalendarBtn)
            for day in weekDayBtns {
                day.setNeedsDisplay()
            }
        }
        
        if let day = weekDay {
            self.loadDayEventsFor(day: WeekDays(rawValue: day.weekDay)!, withProgress: true, withUpdatingCellHeight: false)
        }
    }
}
