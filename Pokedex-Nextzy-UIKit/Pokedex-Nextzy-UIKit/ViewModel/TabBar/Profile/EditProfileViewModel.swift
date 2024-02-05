//
//  EditProfileViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 3/2/2567 BE.
//

import Foundation
import UIKit

protocol EditProfileViewModelDelegate {
    func toggleAlert(messege: String)
    func setProfileData(firstName: String, lastName: String, imageURL: String)
}

class EditProfileViewModel {
    private let authManager = AuthenticationManager.shared
    var delegate: EditProfileViewModelDelegate?
    
    func tapUpdate(firstName: String, lastName: String, newImage: UIImage) {
        guard firstName.count >= 3 && lastName.count >= 3 else {
            self.delegate?.toggleAlert(messege: String(localized: "alert_invalid_name"))
            return
        }
        Task {
            await authManager.editUserData(firstname: firstName,
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
    
    func getProfileData() {
        guard let user = authManager.currentUser else {
            return
        }
        
        self.delegate?.setProfileData(firstName: user.firstname,
                                      lastName: user.lastname,
                                      imageURL: user.profileImageURL)
    }
}
