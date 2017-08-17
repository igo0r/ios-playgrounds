//
//  TimeEventViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 23/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class TimeEventViewController: UITableViewController, EventViewUpdateProtocol {

    static let storyboardID = "TimeEventView"
    
    var waterForm: WeekDayWaterForm?
    var timeEvents = [TimeEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EventTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CellTable")
        
        configureView(withTableView: tableView)
        setupeWeekDayBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar(withTitle: "Day plan. Step 2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timeEvents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellTable", for: indexPath) as? EventTableCell {
            cell.delegation = EventEditTableCell()
            cell.configureCellFor(timeEvent: timeEvents[indexPath.row])
            
            return cell
        }
        
        let cell = EventTableCell()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EventDetailView", sender: (indexPath.row, timeEvents[indexPath.row]))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventDetailView" {
            if let destination = segue.destination as? TimeEventFormController {
                if let timeEventData = sender as? (Int, TimeEvent) {
                    destination.setTimeEvent(data: timeEventData)
                }
            }
        }
    }
    
    func refreshTableCellsHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
