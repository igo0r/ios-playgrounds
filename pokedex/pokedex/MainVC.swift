//
//  ViewController.swift
//  pokedex
//
//  Created by Igor Lantushenko on 22/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    var pokeSound: AVAudioPlayer!
    var searchMode = false
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        pokemonCollectionView.backgroundColor = UIColor.clear
        
        parsePokemonCsv()
        initAudio()
    }

    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        let soundUrl = URL.init(fileURLWithPath: path!)
        
        do {
            try pokeSound = AVAudioPlayer(contentsOf: soundUrl)
            pokeSound.prepareToPlay()
            pokeSound.numberOfLoops = -1
            pokeSound.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parsePokemonCsv() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let pokemon = Pokemon(name: row["identifier"]!, pokedexId: Int(row["id"]!)!)
                
                self.pokemon.append(pokemon)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !searchMode {
            return pokemon.count
        } else {
            return filteredPokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let pokemonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCell {
            let poke: Pokemon
            
            if !searchMode {
                poke = pokemon[indexPath.row]
            } else {
                poke = filteredPokemon[indexPath.row]
            }
            pokemonCell.configureCell(pokemon: poke)
            
            return pokemonCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchMode = false
            view.endEditing(true)
        } else {
            searchMode = true
            let text = searchText.lowercased()
            filteredPokemon = pokemon.filter{$0.name.contains(text)}
        }
        
        pokemonCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke: Pokemon
        if searchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = self.pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "pokeDetail", sender: poke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokeDetail" {
            if let detailVC = segue.destination as? DetailVC {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }
    
    @IBAction func musicBtnPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            if pokeSound.isPlaying {
                pokeSound.pause()
                button.alpha = 0.2
            } else {
                pokeSound.play()
                button.alpha = 1.0
            }
        }
    }
}

