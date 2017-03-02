//
//  PokemonCell.swift
//  pokedex
//
//  Created by Igor Lantushenko on 22/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        imageView.image = UIImage(named: "\(self.pokemon.pokedexId)")
        nameView.text = self.pokemon.name
        
    }
}
