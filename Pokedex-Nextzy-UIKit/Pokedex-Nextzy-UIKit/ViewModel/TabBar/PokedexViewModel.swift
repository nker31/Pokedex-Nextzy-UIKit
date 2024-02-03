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
    private let pokemonManager = PokemonManager.shared
    var delegate: PokedexViewModelDelegate?
    var pokemons: [Pokemon] = []
    
    func loadPokemonData() {
        Task {
            pokemons = await pokemonManager.fetchPokemon()
            DispatchQueue.main.async {
                self.delegate?.toggleViewReload()
            }
        }
    }

}
