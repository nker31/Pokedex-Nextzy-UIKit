//
//  EvolutionCellStoryboard.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 11/2/2567 BE.
//

import UIKit

class EvolutionCellStoryboard: UITableViewCell {

    static let identifier = "EvolutionCellStoryboard"
    var pokemon: Pokemon?
    var filteredPokemonEvo:[Pokemon] = []
    @IBOutlet weak var evolutionStack: UIStackView!
    
    func configCell(pokemon: Pokemon, filteredPokemon: [Pokemon]){
        self.pokemon = pokemon
        self.filteredPokemonEvo = filteredPokemon
        setupUI()
    }
    
    func setupUI(){
        evolutionStack.subviews.forEach { $0.removeFromSuperview() }
        if(filteredPokemonEvo.isEmpty){
            
        } else {
            for i in 0..<(filteredPokemonEvo.count-1){
                if i > 0{
                    let component = EvolutionComponent(pokemonOne: filteredPokemonEvo[i], pokemonTwo: filteredPokemonEvo[i+1], level: "Level 36")
                    evolutionStack.addArrangedSubview(component)
                    
                }else{
                    let component = EvolutionComponent(pokemonOne: filteredPokemonEvo[i], pokemonTwo: filteredPokemonEvo[i+1], level: "Level 16")
                    evolutionStack.addArrangedSubview(component)
                }
            }
        }
    }
}
