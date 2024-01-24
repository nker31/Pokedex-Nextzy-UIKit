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
    let pokemonURL = "https://raw.githubusercontent.com/wirunpong-j/PokedexAPIMock/master/pokemons.json"
    
    func fecthPokemonAPI() async{
        
        // pokemon API endpoint
        let apiUrl = "https://raw.githubusercontent.com/wirunpong-j/PokedexAPIMock/master/pokemons.json"
        
        // make API call
        AF.request(apiUrl).responseDecodable(of: [Pokemon].self){ response in
            switch response.result {
                // if success
            case .success(let pokemonArray):
                self.pokemons = pokemonArray
                print("Debugger: Fetched pokemon data success")
                // if failed
            case .failure(let error):
                print("Debugger: Fetched pokemon data failed")
            }
        }
    }


    
}
