//
//  EvolutionCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 26/1/2567 BE.
//

import UIKit

class EvolutionCell: UITableViewCell {
    // MARK: - Variables
    static let identifier = "evoCell"
    var pokemon: Pokemon?
    var filteredPokemonEvo:[Pokemon] = []
    var componentArray:[UIView] = []
    
    func configCell(pokemon: Pokemon, filteredPokemon: [Pokemon]){
        self.pokemon = pokemon
        self.filteredPokemonEvo = filteredPokemon
        self.setupUI()
    }
    
    func setupUI(){
        self.backgroundColor = .white
        
        if(filteredPokemonEvo.isEmpty){
            
        }else{
            for i in 0..<(filteredPokemonEvo.count-1){
                if i > 0{
                    let component = EvolutionComponent(pokemonOne: filteredPokemonEvo[i], pokemonTwo: filteredPokemonEvo[i+1], level: "Level 36")
                    self.componentArray.append(component)
                    
                }else{
                    let component = EvolutionComponent(pokemonOne: filteredPokemonEvo[i], pokemonTwo: filteredPokemonEvo[i+1], level: "Level 16")
                    self.componentArray.append(component)
                }
                
                
            }
        }
        
        
        let evolutionStack = UIStackView(arrangedSubviews: self.componentArray)
        evolutionStack.axis = .vertical
        evolutionStack.spacing = 30
        self.addSubview(evolutionStack)
        evolutionStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            evolutionStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            evolutionStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            evolutionStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            evolutionStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -300)
        ])
    }
    
    override func prepareForReuse() {
        self.componentArray = []
    }
    
}

