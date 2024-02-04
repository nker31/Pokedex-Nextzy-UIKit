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
    
    static var shared = MyPokemonManager()
    var myPokemonsID: [String] = []
    
    func fetchMyPokemon(userID: String) async {
        let db = Firestore.firestore()
        do{
            let documentSnapshot = try await  db.collection("pokemons").document(userID).getDocument()
            
            if documentSnapshot.exists{
                let data = documentSnapshot.data()
                self.myPokemonsID = data?["favPokemon"] as? [String] ?? ["nothing here"]
            }else{
                try await db.collection("pokemons").document(userID).setData(["favPokemon": []])
            }
        }
        catch{
            print("Debugger: fetch my pokemon failed")
        }
    }
    
    func addPokemonToFavList(pokemonID: [String], userID: String) async {
        // Firebase
        let db = Firestore.firestore()
        let documentRef = db.collection("pokemons").document(userID)
        
        do {
            try await documentRef.updateData([
                "favPokemon": pokemonID
            ])
            print("Debugger: updated favorite pokemon successfully")
            await self.fetchMyPokemon(userID: userID)
        } catch {
            print("Debugger: got an error from updating favorite pokemon")
        }
        
    }
}
