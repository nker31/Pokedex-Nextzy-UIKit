//
//  PokedexViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 24/1/2567 BE.
//

import Foundation
import Alamofire

class PokedexViewModel{
    var pokemons: [Pokemon]?
    
    func fecthPokemonAPI() async -> [Pokemon]{
        
        // pokemon API endpoint
        let apiUrl = "https://raw.githubusercontent.com/wirunpong-j/PokedexAPIMock/master/pokemons.json"
        
        // make API call
        await AF.request(apiUrl).responseDecodable(of: [Pokemon].self){ response in
            switch response.result {
                // if success
            case .success(let pokemonArray):
                self.pokemons = pokemonArray
                print("Debugger: Fetched pokemon data success")
                
                // if failed
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
