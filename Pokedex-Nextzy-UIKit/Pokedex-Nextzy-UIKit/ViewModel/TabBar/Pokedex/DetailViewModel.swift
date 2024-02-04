//
//  DetailViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 4/2/2567 BE.
//

import Foundation

protocol DetailViewModelDelegate {
    func toggleNavbarReload()
    func toggleTableViewReload()
}

class DetailViewModel {
    enum selectedMenu {
        case about
        case stat
        case evolution
    }
    
    private let pokemonManager = PokemonManager.shared
    private let myPokemonManager = MyPokemonManager.shared
    private let authManager = AuthenticationManager.shared
    var delegate: DetailViewModelDelegate?
    
    var isLiked = false
    var isPresentMenu = selectedMenu.about
    var pokemon: Pokemon
    var filteredPokemon: [Pokemon] = []
    var myPokemonID: [String]
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.myPokemonID = myPokemonManager.myPokemonsID
        self.filterEvolutionPokemon()
    }
    
    func filterEvolutionPokemon() {
        if let pokemons = pokemonManager.pokemons {
            self.filteredPokemon = pokemons.filter { self.pokemon.evolutions.contains($0.id) }
        }
        print("Debugger: Filtered Pokemon = \(self.filteredPokemon)")
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
        
        checkFavorite()
    }
    
    func checkFavorite() {
        isLiked = myPokemonID.contains(pokemon.id)
        delegate?.toggleNavbarReload()
    }
    
    func tapChangeMenu(index: Int) {
        switch index {
        case 0:
            isPresentMenu = selectedMenu.about
        case 1:
            isPresentMenu = selectedMenu.stat
        case 2:
            isPresentMenu = selectedMenu.evolution
        default:
            isPresentMenu = selectedMenu.about
        }
        delegate?.toggleTableViewReload()
    }
}
