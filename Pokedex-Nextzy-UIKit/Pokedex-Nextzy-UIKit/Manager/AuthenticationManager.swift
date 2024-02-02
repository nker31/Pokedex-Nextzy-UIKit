//
//  AuthenticationManager.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class AuthenticationManager {
    
    var userSession: FirebaseAuth.User?
    var currentUser: User?

    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func fetchUserData() async {
        guard let userID = Auth.auth().currentUser?.uid else{ return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(userID).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        print("Debugger: fetched current user: \(String(describing: self.currentUser))")
    }
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        await fetchUserData()
    }
    
    func signOut() {
        do{
            print("Debugger: sign out tapped")
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            print("Debugger: sign out successfully")
        }catch {
            print("Failed to sign out with error: \(error.localizedDescription)")
        }
        
    }
    
}

extension AuthenticationManager {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }

}
