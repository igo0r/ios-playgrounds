//
//  Pokemon.swift
//  pokedex
//
//  Created by Igor Lantushenko on 22/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _defense: String!
    private var _baseAttack: String!
    private var _height: String!
    private var _weight: String!
    private var _type: String!
    private var _types: [String]!
    private var _description: String!
    private var _nextEvolution: String!
    private var _nextEvolutionId: String!
    private var _pokemonUrl: String!
    
    var defense: String {
        if _defense == nil {
            return ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            return ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            return ""
        }
        return _weight
    }
    
    var baseAttack: String {
        if _baseAttack == nil {
            return ""
        }
        return _baseAttack
    }
    
    var nextEvolution: String {
        if _nextEvolution == nil {
            return ""
        }
        return _nextEvolution
    }
    
    var description: String {
        if _description == nil {
            return ""
        }
        return _description
    }
    
    var name: String {
        if _name == nil {
            return ""
        }
        return _name
    }
    
    var type: String {
        if _type == nil {
            return ""
        }
        return _type
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            return ""
        }
        return _nextEvolutionId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(pokedexId)/"
    }
    
    func downloadCompleteDetail(complete: @escaping DownloadComplete) {
        Alamofire.request(self._pokemonUrl).responseJSON { (response) in
            if let dict = response.result.value as? [String:AnyObject] {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [AnyObject] {
                    for type in types {
                        if let currentType = type as? [String:AnyObject] {
                            let str = currentType["name"] as! String
                            if self._type == nil {
                                self._type = str.capitalized
                            } else {
                                self._type.append("/\(str.capitalized)")
                            }
                        }
                    }
                }
                if let evolutions = dict["evolutions"] as? [AnyObject], evolutions.count > 1 {
                    if let evoText = evolutions[0]["to"] as? String, !evoText.contains("mega") {
                        
                        if let evoLvl = evolutions[0]["level"] as? Int {
                            self._nextEvolution = evoText + " LVL \(evoLvl)"
                        }
                    }
                    if let evoUrl = evolutions[0]["resource_uri"] as? String {
                        let components = evoUrl.components(separatedBy: "/")
                        self._nextEvolutionId = components[components.count - 2]
                    }
                }
                if let descriptions = dict["descriptions"] as? [AnyObject], descriptions.count > 1 {
                    if let url = descriptions[0]["resource_uri"] as? String {
                        Alamofire.request("\(BASE_URL)\(url)").responseJSON { (response) in
                            if let descrDict = response.result.value as? [String:AnyObject] {
                                if let descr = descrDict["description"] as? String! {
                                    
                                    self._description = descr.replacingOccurrences(of: "POKMON", with: "POKEMON")
                                }
                            }
                            complete()
                        }
                        
                    }
                }
            }
            
            complete()
        }
    }
}
