//
//  MyPokemonViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 27/1/2567 BE.
//

import Firebase
import FirebaseFirestoreSwift

class MyPokemonViewModel{
    var myPokemonIDs:[String] = []
    var currentUserID: String = ""
    
    func fetchMyPokemon(userID: String) async{
        self.currentUserID = userID
        
        let db = Firestore.firestore()
        do{
            let documentSnapshot = try await  db.collection("pokemons").document(userID).getDocument()
            
            if documentSnapshot.exists{
                // fetch pokemon id array
                let data = documentSnapshot.data()
                // assign fetced array to view model array
                myPokemonIDs = data?["favPokemon"] as? [String] ?? ["nothing here"]
            }else{
                // if document is not exist then create new document from userID
                try await db.collection("pokemons").document(userID).setData(["favPokemon": []])
            }
        }
        catch{
            
        }
    }
    
    func addPokemonToFavList(pokemonID: String) async{
        
        // local part
        if(self.myPokemonIDs.contains(pokemonID)){
            if let targetIndex = myPokemonIDs.firstIndex(of: pokemonID){
                myPokemonIDs.remove(at: targetIndex)
                print("removed \(pokemonID) already")
                print("Debugger: my pokemon array after remove: \(myPokemonIDs)")
            }
            
        }else{
            self.myPokemonIDs.append(pokemonID)
            print("Debugger: This pokemon was added")
            print("Debugger: my pokemon array after add: \(myPokemonIDs)")
            
        }
        
        // Firebase
        let db = Firestore.firestore()
        let documentRef = db.collection("pokemons").document(self.currentUserID)
        
        do {
            try await documentRef.updateData([
                "favPokemon": myPokemonIDs
            ])
            print("Debugger: updated favorite pokemon successfully")
            await self.fetchMyPokemon(userID: currentUserID)
        } catch {
            print("Debugger: got an error from updating favorite pokemon")
        }
        
        
    }
    
}
