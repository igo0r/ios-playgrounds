//
//  DetailVC.swift
//  pokedex
//
//  Created by Igor Lantushenko on 24/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var typeView: UILabel!
    @IBOutlet weak var defenseView: UILabel!
    @IBOutlet weak var heightView: UILabel!
    @IBOutlet weak var weightView: UILabel!
    @IBOutlet weak var baseAttackView: UILabel!
    @IBOutlet weak var pokedexIDView: UILabel!
    @IBOutlet weak var nextEvolutionView: UILabel!
    @IBOutlet weak var currentEvoImgView: UIImageView!
    @IBOutlet weak var nextEvoImgView: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetView()
        
        let currentImg = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImgView.image = currentImg
        mainImageView.image = currentImg
        
        pokemon.downloadCompleteDetail {
            self.updateUI()
        }
    }
    
    func resetView() {
        titleView.text = ""
        defenseView.text = ""
        heightView.text = ""
        weightView.text = ""
        baseAttackView.text = ""
        pokedexIDView.text = ""
        typeView.text = ""
        descriptionView.text = ""
        nextEvolutionView.text = ""
        nextEvoImgView.isHidden = true
    }
    
    func updateUI() {
        
        titleView.text = pokemon.name
        defenseView.text = pokemon.defense
        heightView.text = pokemon.defense
        weightView.text = pokemon.weight
        baseAttackView.text = pokemon.baseAttack
        pokedexIDView.text = "\(pokemon.pokedexId)"
        typeView.text = pokemon.type
        descriptionView.text = pokemon.description
        var nextEvoTxt = "Next Evolution: "
        nextEvoTxt += pokemon.nextEvolution == "" ? "No Evolution" : pokemon.nextEvolution
        nextEvolutionView.text = nextEvoTxt
        
        if pokemon.nextEvolutionId == "" {
            nextEvoImgView.isHidden = true
        } else {
            nextEvoImgView.isHidden = false
            nextEvoImgView.image = UIImage(named: pokemon.nextEvolutionId)
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
           dismiss(animated: true, completion: nil)
    }
}
