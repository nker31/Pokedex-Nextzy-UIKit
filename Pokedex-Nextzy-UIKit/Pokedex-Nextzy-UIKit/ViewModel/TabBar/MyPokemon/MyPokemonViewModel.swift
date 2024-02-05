//
//  MyPokemonViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 27/1/2567 BE.
//

import Foundation

protocol MyPokemonViewModelDelegate {
    func toggleViewReload()
}

class MyPokemonViewModel {
    
    enum DisplayType {
        case oneColumn
        case twoColumns
        case threeColumns
    }
    
    private let pokemonManager = PokemonManager.shared
    private let myPokemonManager = MyPokemonManager.shared
    var myPokemonsID: [String] = []
    var displayedPokemons: [Pokemon] = []
    var delegate: MyPokemonViewModelDelegate?
    var collectionViewDisplayType: DisplayType = .twoColumns
    
    func loadMyPokemonData() {
        guard let pokemons = pokemonManager.pokemons else {
            return
        }
        myPokemonsID = myPokemonManager.myPokemonsID
        displayedPokemons = pokemons.filter { myPokemonsID.contains($0.id) }
        self.delegate?.toggleViewReload()
    }
    
    func tapChangeDisplayType() {
        switch collectionViewDisplayType {
        case .oneColumn:
            collectionViewDisplayType = .twoColumns
        case .twoColumns:
            collectionViewDisplayType = .threeColumns
        case .threeColumns:
            collectionViewDisplayType = .oneColumn
        }
        
        delegate?.toggleViewReload()
    }
    
}

