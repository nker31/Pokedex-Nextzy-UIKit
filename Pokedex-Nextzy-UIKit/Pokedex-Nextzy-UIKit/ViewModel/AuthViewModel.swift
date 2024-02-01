//
//  AuthViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

protocol AuthViewModelDelegate {
    func toggleAlert(messege: String)
    func navigateToNextView()
    func setUserData(firstName: String, lastName: String, imageURL: String)
}

class AuthViewModel {
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    var delegate: AuthViewModelDelegate?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    // MARK: - Authentication
    
    func fetchUserData() async {
        guard let currentUserUID = Auth.auth().currentUser?.uid else{ return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(currentUserUID).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        print("Debugger: got current user: \(String(describing: self.currentUser))")
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
        }catch {
            print("Failed to sign out with error: \(error.localizedDescription)")
        }
        
    }
    
    func register(withEmail email: String, password: String, firstname: String, lastname: String, profileImageData: UIImage, completion: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // failed to register
                completion(.failure(error))
                return
            }
            
            // get user creation result
            guard let authResult = authResult else {
                let error = NSError(domain: "Registration error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            // upload image
            Task{
                await self.uploadImage(image: profileImageData, imageName: authResult.user.uid) { result in
                    
                    switch result {
                    // if upload success then get put image url to user model
                    case .success(let imageURL):
                        let user = User(id: authResult.user.uid, firstname: firstname, lastname: lastname, email: email, profileImageURL: imageURL.absoluteString)
                        
                        // encode user model then upload to firebase
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
        
        // create firebase reference
        let userDocRef = Firestore.firestore().collection("users").document(currentUserUID)
        let batch = Firestore.firestore().batch()
        
        // upload new profile image to firebase storage
        await self.uploadImage(image: profileImageData, imageName: currentUserUID) { result in
            
            switch result {
                // if success
            case .success(let newImageURL):
                let stringURL = newImageURL.absoluteString
                // then update user document
                batch.updateData(["firstname": firstname, "lastname": lastname, "profileImageURL": stringURL], forDocument: userDocRef)
                batch.commit()
                Task{
                    await self.fetchUserData()
                }
                print("Debugger: Updated user data complete")
                self.delegate?.toggleAlert(messege: String(localized: "alert_update_success"))
                completion(.success(true))
                
                // if failed
            case .failure(let errorMessage):
                print("Error uploading from edit profile: \(errorMessage.localizedDescription)")
                self.delegate?.toggleAlert(messege: String(localized: "alert_update_failed"))
                completion(.failure(errorMessage))
            }
        }
        
    }
    
    func uploadImage(image: UIImage, imageName: String, completion: @escaping (Result<URL, Error>) -> Void) async {
        // compress image
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Debugger: Failed to compress image")
            return
        }
        
        // set image storage reference
        let storageRef = Storage.storage().reference(withPath: "profile_images/\(imageName).jpg")
        
        // then upload image
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                // if uploaded image successfully then get image url
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

    
    
    
}

extension AuthViewModel {
    // MARK: - Validation Functions
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    func signInValidation(email: String, password: String) -> Bool {
        if (isValidEmail(email)) {
            if (isValidPassword(password)) {
                return true
            }
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_password"))
            return false
        }
        else {
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_email"))
            return false
        }
    }
    
    func registerValidation(email: String,
                            password: String,
                            confirmPassword: String,
                            firstName: String,
                            lastName: String) -> Bool {
        
        guard self.isValidEmail(email) else {
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_email"))
            return false
        }

        guard self.isValidPassword(password) else {
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_password"))
            return false
        }

        guard password == confirmPassword else {
            self.delegate?.toggleAlert(messege: String(localized: "alert_invalid_confirm_password"))
            return false
        }

        guard firstName.count >= 3 && lastName.count >= 3 else {
            self.delegate?.toggleAlert(messege: String(localized: "alert_invalid_name"))
            return false
        }
        
        return true

    }
}

extension AuthViewModel {
    
    func tapLogin(email: String, password: String) {
        if (signInValidation(email: email, password: password)) {
            Task{
                do {
                    try await self.signIn(email: email, password: password)
                    DispatchQueue.main.async {
                        self.delegate?.navigateToNextView()
                    }
                } catch {
                    print("Debugger: got error \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.delegate?.toggleAlert(messege: String(localized: "alert_login_failed"))
                    }
                }
            }
        }
    }
    
    func tapRegister(email: String,
                     password: String,
                     confirmPassword: String, 
                     firstName: String,
                     lastName: String,
                     profileImageData: UIImage) {
        
        let isValid = registerValidation(email: email, 
                                         password: password,
                                         confirmPassword: confirmPassword,
                                         firstName: firstName,
                                         lastName: lastName)
        
        if (isValid) {
            self.register(withEmail: email, 
                          password: password,
                          firstname: firstName,
                          lastname: lastName,
                          profileImageData: profileImageData)
            { result in
                
                switch result {
                case .success(_):
                    self.delegate?.navigateToNextView()
                case .failure(_):
                    self.delegate?.toggleAlert(messege: String(localized: "alert_register_failed"))
                }
                
            }
        }
    }
    
    func tapForgotPassword(email: String) {
        guard self.isValidEmail(email) else {
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_email"))
            return
        }
        
        self.resetPassword(withEmail: email) { result in
            switch result {
            case .success(_):
                self.delegate?.toggleAlert(messege: String(localized: "alert_reset_success"))
            case .failure(_):
                self.delegate?.toggleAlert(messege: String(localized: "alert_reset_failed"))
            }
        }
    }
    
    func tapUpdate(firstName: String, lastName: String, newImage: UIImage) {
        guard firstName.count >= 3 && lastName.count >= 3 else {
            self.delegate?.toggleAlert(messege: String(localized: "alert_invalid_name"))
            return
        }
        
        Task {
            await self.editUserData(firstname: firstName,
                                    lastname: lastName,
                                    profileImageData: newImage)
            { result in
                switch result {
                case .success(_):
                    self.delegate?.toggleAlert(messege: String(localized: "alert_update_success"))
                case .failure(_):
                    self.delegate?.toggleAlert(messege: String(localized: "alert_update_failed"))
                }
            }
        }
    }
    
    func tapSignOut() {
        self.signOut()
        self.delegate?.navigateToNextView()
    }
    
    func getProfileData() {
        guard let user = currentUser else {
            return
        }
        
        self.delegate?.setUserData(firstName: user.firstname,
                                   lastName: user.lastname,
                                   imageURL: user.profileImageURL)
    }
    
}
