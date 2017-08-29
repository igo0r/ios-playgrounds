//
//  TeamManager.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 23/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

class TeamManager {
    static let apiClient = ApiClient()
    private init() {}
    
    static func getAllTeams(ch: () -> ()) {
        if let urlComp = apiClient.getAllTeamsURL() {
            apiClient.composeRequest(withUrl: urlComp) { (responseObject, error) in
                if let jsonTeams = responseObject as? [String:AnyObject] {
                    var teams = [String]()
                    for jsonTeam in jsonTeams {
                        //teams.append(jsonTeam)
                    }
                    
                    
                }
            }
        }
    }
}
