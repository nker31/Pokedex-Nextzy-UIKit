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
    static var shared = AuthenticationManager()
    private(set) var userSession: FirebaseAuth.User?
    private(set) var currentUser: User?

    private init() {
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
    
    func resetPassword(withEmail email: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Failed to reset password: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Sent password reset email successfully")
                completion(.success("Sent password reset email successfully"))
            }
        }
    }
    
    func register(withEmail email: String, password: String, firstname: String, lastname: String, profileImageData: UIImage, completion: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let authResult = authResult else {
                let error = NSError(domain: "Registration error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            // upload image
            Task{
                await self.uploadImage(image: profileImageData, imageName: authResult.user.uid) { result in
                    
                    switch result {
                    case .success(let imageURL):
                        let user = User(id: authResult.user.uid, firstname: firstname, lastname: lastname, email: email, profileImageURL: imageURL.absoluteString)
                        if let encodedUser = try? Firestore.Encoder().encode(user){
                            Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
                            print("Debugger: \(user)")
                            completion(.success(user))
                        }
                    case .failure(let uploadError):
                        print("Error uploading image: \(uploadError.localizedDescription)")
                        completion(.failure(uploadError))
                    }
                }
            }
        }
    }
    
    func editUserData(firstname: String, lastname: String, profileImageData: UIImage, completion: @escaping (Result<Bool, Error>) -> Void) async {
        print("Debugger: editUserData is being called")
        // get current user uid
        guard let currentUserUID = self.currentUser?.id else {
            print("Debugger: error user session")
            return
        }
        
        let userDocRef = Firestore.firestore().collection("users").document(currentUserUID)
        let batch = Firestore.firestore().batch()
        
        await self.uploadImage(image: profileImageData, imageName: currentUserUID) { result in
            
            switch result {
            case .success(let newImageURL):
                let stringURL = newImageURL.absoluteString
                batch.updateData(["firstname": firstname, "lastname": lastname, "profileImageURL": stringURL], forDocument: userDocRef)
                batch.commit()
                Task {
                    await self.fetchUserData()
                }
                print("Debugger: Updated user data complete")
                completion(.success(true))
            case .failure(let errorMessage):
                print("Error uploading from edit profile: \(errorMessage.localizedDescription)")
                completion(.failure(errorMessage))
            }
        }
        
    }
    
    private func uploadImage(image: UIImage, imageName: String, completion: @escaping (Result<URL, Error>) -> Void) async {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Debugger: Failed to compress image")
            return
        }
        
        let storageRef = Storage.storage().reference(withPath: "profile_images/\(imageName).jpg")
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                storageRef.downloadURL { (url, error) in
                    if let url = url {
                        completion(.success(url))
                    } else if let error = error {
                        completion(.failure(error))
                    }
                }
            }
        }
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
