//
//  PokedexViewViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 4/2/2567 BE.
//

import Foundation

protocol PokedexViewModelDelegate {
    func toggleViewReload()
    func toggleAlert(messege: String)
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
            do {
                pokemons = try await pokemonManager.fetchPokemon()
                DispatchQueue.main.async {
                    self.delegate?.toggleViewReload()
                }
            } catch {
                print("Debugger: got error \(error) from PokemonManager")
                DispatchQueue.main.async {
                    self.delegate?.toggleAlert(messege: "Failed to fetch pokemon data")
                }
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
