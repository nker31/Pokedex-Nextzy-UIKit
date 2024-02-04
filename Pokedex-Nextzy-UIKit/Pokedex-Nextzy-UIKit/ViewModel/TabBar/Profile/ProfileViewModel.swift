//
//  ProfileViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 3/2/2567 BE.
//

import Foundation

protocol ProfileViewModelDelegate {
    func setProfileData(firstName: String, lastName: String, imageURL: String)
    func navigateToNextView()
}

class ProfileViewModel {
    
    private let authManager = AuthenticationManager.shared
    var delegate: ProfileViewModelDelegate?
    
    func getProfileData() {
        guard let user = authManager.currentUser else {
            return
        }
        
        self.delegate?.setProfileData(firstName: user.firstname,
                                      lastName: user.lastname,
                                      imageURL: user.profileImageURL)
    }
    
    func tapSignOut() {
        authManager.signOut()
        self.delegate?.navigateToNextView()
    }
}
