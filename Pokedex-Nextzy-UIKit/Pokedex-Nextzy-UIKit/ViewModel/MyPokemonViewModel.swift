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
    
    func fetchMyPokemon(userID: String) async{
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
    
}
