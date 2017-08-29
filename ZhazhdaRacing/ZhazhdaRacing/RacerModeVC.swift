//
//  RacerModeVC.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 18/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

enum TableType: Int {
    case TeamLastLaps = 0
    case GridBestLaps
    case GridLastLap
    case GridGapPositions
    
    func getValues() -> [GridInfo] {
        switch self {
        case .TeamLastLaps:
            return teamLastLaps
        case .GridBestLaps:
            return gridBestLaps
        case .GridLastLap:
            return gridLastLap
        case .GridGapPositions:
            return gridGapsPosition
        }
    }
}

class RacerModeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableViews: [UITableView]!
    static let storyboardID = "RacerVC"
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        let cell = UINib(nibName: TeamCell.name, bundle: Bundle.main)
        for (index, _) in tableViews.enumerated() {
            tableViews[index].delegate = self
            tableViews[index].dataSource = self
            tableViews[index].register(cell, forCellReuseIdentifier: TeamCell.identifier)
            tableViews[index].tableFooterView = UIView()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableType = TableType(rawValue: tableView.tag) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: TeamCell.identifier, for: indexPath) as? TeamCell {
                cell.configureCellFor(gridInfo: tableType.getValues()[indexPath.row])
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableType = TableType(rawValue: tableView.tag) {
            return tableType.getValues().count
        }
        
        return 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if isLandScapeMode() {
            
        }
    }
}
