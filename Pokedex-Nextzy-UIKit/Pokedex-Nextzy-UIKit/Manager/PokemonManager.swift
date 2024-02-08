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
    let urlString = "https://raw.githubusercontent.com/wirunpong-j//master/pokemons.json"

    func fetchPokemon() async throws -> [Pokemon] {
        guard let url = URL(string: urlString) else { throw FetchError.invalidURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let pokemons = try JSONDecoder().decode([Pokemon].self, from: data)
            print("Debugger: pokemon data count: \(pokemons.count)")
            self.pokemons = pokemons
            return pokemons
        } catch {
            print("Debugger: got error \(error)")
            throw FetchError.failedToFetch
        }
    }
}

enum FetchError: Error {
    case invalidURL
    case failedToFetch
}
