//
//  MyPokemonManager.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 4/2/2567 BE.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class MyPokemonManager {
    
    static let shared: MyPokemonManager = MyPokemonManager()
    private(set) var myPokemonsID: [String] = []
    
    func fetchMyPokemon(userID: String) async throws {
        guard !userID.isEmpty else {
            print("Debugger: (MyPokemonManager) userID is empty")
            return
        }
        let db = Firestore.firestore()
        do {
            let documentSnapshot = try await db.collection("pokemons").document(userID).getDocument()
            
            if documentSnapshot.exists {
                let data = documentSnapshot.data()
                self.myPokemonsID = data?["favPokemon"] as? [String] ?? ["nothing here"]
            } else {
                try await db.collection("pokemons").document(userID).setData(["favPokemon": []])
            }
        } catch {
            print("Debugger: (MyPokemonManager) fetch my pokemon failed")
            throw error
        }
    }

    func addPokemonToFavList(pokemonID: [String], userID: String) async throws {
        let db = Firestore.firestore()
        let documentRef = db.collection("pokemons").document(userID)
        
        do {
            try await documentRef.updateData(["favPokemon": pokemonID])
            print("Debugger: updated favorite pokemon successfully")
            try await self.fetchMyPokemon(userID: userID)
        } catch {
            print("Debugger: (MyPokemonManager) got an error from updating favorite pokemon")
            throw error
        }
    }

}
