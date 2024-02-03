//
//  PokedexViewViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 4/2/2567 BE.
//

import Foundation

protocol PokedexViewModelDelegate {
    func toggleViewReload()
}

class PokedexViewModel {
    
    enum DisplayType {
        case oneColumn
        case twoColumns
        case threeColumns
    }
    
    private let pokemonManager = PokemonManager.shared
    var delegate: PokedexViewModelDelegate?
    var pokemons: [Pokemon] = []
    var collectionViewDisplayType: DisplayType = .twoColumns
    
    func loadPokemonData() {
        Task {
            pokemons = await pokemonManager.fetchPokemon()
            DispatchQueue.main.async {
                self.delegate?.toggleViewReload()
            }
        }
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
    }

}
