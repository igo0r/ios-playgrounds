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
    
    func getTitle() -> String {
        switch self {
        case .TeamLastLaps:
            return "Team last lap"
        case .GridBestLaps:
            return "Race best laps"
        case .GridLastLap:
            return "Grid last lap"
        case .GridGapPositions:
            return "Grid gap"
        }
    }
}

class RacerModeVC: UIViewController {

    @IBOutlet var tableViews: [UITableView]!
    static let storyboardID = "RacerVC"
    
    var currentTeam = Team()
    
    var popupTV: UITableView = UITableView()
    
    lazy var items: [Team] = {
        return teams
    }()
    
 /*   lazy var popoverContentController: UINavigationController = {
        let controller = TeamListTVC(style: .plain)
        controller.selectionHandler = self.selectionHandler
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }()
    lazy var popoverController: UIPopoverController = {
        return UIPopoverController(contentViewController: self.popoverContentController)
    }()*/

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureNavBar(withTitle: currentTeam.fullName)
        addBarLeftRightActionsWith(leftBtnTitle: "Back", rightBtnTitle: "🏎")
        let cell = UINib(nibName: TeamCell.name, bundle: Bundle.main)
        for (index, _) in tableViews.enumerated() {
            tableViews[index].delegate = self
            tableViews[index].dataSource = self
            tableViews[index].register(cell, forCellReuseIdentifier: TeamCell.identifier)
            tableViews[index].tableFooterView = UIView()
            tableViews[index].bounces = false
            tableViews[index].showsVerticalScrollIndicator = false
        }
        
        getTeamData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        for (index, _) in tableViews.enumerated() {
            tableViews[index].layoutIfNeeded()
        }
        
    }
    
    func getTeamData() {
        TeamManager.getAllTeams() { teams in
            let tI = UserDefaultUtil.getTeamIdentifier()
            let filteredTeams = teams.filter{ $0.identifier == tI }
            
            self.currentTeam = filteredTeams.count > 0 ? filteredTeams[0] : teams[0]
            self.reloadTablesData()
        }
    }
    
    func reloadTablesData() {
        _ = tableViews.map{$0.reloadData()}
    }
}
