//
//  TeamListTVC.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 01/09/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class TeamListTVC:  UITableViewController {
    static let identifier = "Cell"
    
    var cancelBarButtonItem: UIBarButtonItem!
    var selectionHandler: ((_ selectedItem: Team) -> Void?)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TeamListTVC.identifier)
        configureView()        
        //cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(TeamListTVC.performCancel))
        //navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: TeamListTVC.identifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = teams[indexPath].fullName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = teams[indexPath]
        selectionHandler?(selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
