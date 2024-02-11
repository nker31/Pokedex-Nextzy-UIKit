//
//  PokemonManager.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation
import Alamofire

class PokemonManager {
    static let shared: PokemonManager = PokemonManager()
    private(set) var pokemons: [Pokemon]?
    private let urlString: String = "https://raw.githubusercontent.com/wirunpong-j/PokedexAPIMock/master/pokemons.json"

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
