//
//  DetailViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 4/2/2567 BE.
//

import Foundation

protocol DetailViewModelDelegate {
    func toggleViewReload()
}

class DetailViewModel {
    private let pokemonManager = PokemonManager.shared
    private let myPokemonManager = MyPokemonManager.shared
    private let authManager = AuthenticationManager.shared
    var pokemon: Pokemon
    var filteredPokemon: [Pokemon] = []
    var myPokemonID: [String]
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.myPokemonID = myPokemonManager.myPokemonsID
    }
    
    func tapFavorite(pokemonID: String) {
        guard let userID = authManager.currentUser?.id else {
            return
        }
        
        if self.myPokemonID.contains(pokemonID) {
            if let targetIndex = myPokemonID.firstIndex(of: pokemonID){
                myPokemonID.remove(at: targetIndex)
            }
        } else {
            self.myPokemonID.append(pokemonID)
        }
        
        Task {
            await myPokemonManager.addPokemonToFavList(pokemonID: self.myPokemonID, userID: userID)
        }  
    }
}
