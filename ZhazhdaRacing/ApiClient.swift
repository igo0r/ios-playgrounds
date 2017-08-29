//
//  ApiClient.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 17/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import Alamofire

enum ServerUrl: String {
    case defaults = "default"
    case teams = "teams"
}

struct ApiClient {
    
    func getAllTeamsURL() -> URL? {
        let url = BASE_URL + ServerUrl.teams.rawValue
        
        if let urlComp = NSURLComponents(string:url) {
            return urlComp.url
        }
        
        return nil
    }

    
    func getData(type: ServerUrl) -> URL? {
        let url = BASE_URL + type.rawValue
        
        if let urlComp = NSURLComponents(string:url) {
            var queryItems: [NSURLQueryItem] = []
            queryItems.append(NSURLQueryItem(name: "lat", value: "lat"))
            queryItems.append(NSURLQueryItem(name: "lon", value: "lon"))

            urlComp.queryItems = queryItems as [URLQueryItem]?
            return urlComp.url
        }
        
        return nil
    }
    
    func composeRequest(withUrl url: URL, completionHandler: @escaping (AnyObject?, NSError?) -> ()){
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as AnyObject?, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
}
