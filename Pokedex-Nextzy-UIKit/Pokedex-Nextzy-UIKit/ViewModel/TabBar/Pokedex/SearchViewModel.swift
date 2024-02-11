//
//  SearchViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 4/2/2567 BE.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func toggleCollectionViewReload()
    func toggleEmptyState(isHidden: Bool, searchText: String)
}

class SearchViewModel {
    private let pokemonManager = PokemonManager.shared
    weak var delegate: SearchViewModelDelegate?
    var pokemons: [Pokemon] = []
    var filteredPokemon: [Pokemon] = []
    
    init() {
        self.setPokemon()
    }
    
    func setPokemon() {
        guard let pokemons = pokemonManager.pokemons else {
            return
        }
        self.pokemons = pokemons
    }
    
    func onSearchTextChange(searchText: String) {
        if searchText.isEmpty {
            self.filteredPokemon = []
        } else {
            let result = pokemons.filter { $0.name.starts(with: searchText) }
            
            if result.isEmpty {
                delegate?.toggleEmptyState(isHidden: false, searchText: searchText)
                self.filteredPokemon = []
            } else {
                delegate?.toggleEmptyState(isHidden: true, searchText: searchText)
                self.filteredPokemon = result
            }
        }
        delegate?.toggleCollectionViewReload()
    }
}
