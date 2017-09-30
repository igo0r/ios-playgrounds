//
//  RacerModeVCExt.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 30/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension RacerModeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 25))
        returnedView.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = UIScreen.main.bounds
        returnedView.addSubview(blurView)
        
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: view.frame.size.width, height: 25))
        label.font = fontMedium19
        if let tableType = TableType(rawValue: tableView.tag) {
            label.text = tableType.getTitle()
        } else {
            label.text = ""
        }
        
        label.textColor = creamWhite
        returnedView.addSubview(label)
        returnedView.cornerRadius = 10
        
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
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

}
