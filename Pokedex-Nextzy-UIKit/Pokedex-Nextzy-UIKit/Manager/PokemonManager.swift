//
//  PokemonManager.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation
import Alamofire

class PokemonManager {
    static var shared = PokemonManager()
    var pokemons: [Pokemon]?
    let url = "https://raw.githubusercontent.com/wirunpong-j/PokedexAPIMock/master/pokemons.json"
    
    func fetchPokemon() async -> [Pokemon] {
        AF.request(url).responseDecodable(of: [Pokemon].self)
        { response in
            switch response.result {
            case .success(let pokemonArray):
                self.pokemons = pokemonArray
                print("Debugger: Fetched pokemon data success")
            case .failure(_):
                print("Debugger: Fetched pokemon data failed")
            }
        }
        
        if let returnedPokemon = self.pokemons{
            print("Debugger: returned pokemon \(returnedPokemon.count)")
            return returnedPokemon
        }
        print("Debugger: returned nothing")
        return []
    }
    
}
