//
//  RegisterViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation
import UIKit

protocol RegisterViewModelDelegate: AnyObject {
    func toggleAlert(messege: String)
    func navigateToNextView()
    func segueToNextView()
}

class RegisterViewModel {
    
    enum RegisterType {
        case programmatic
        case storyboard
    }
    
    // MARK: - Variables
    private let authManager = AuthenticationManager.shared
    weak var delegate: RegisterViewModelDelegate?
    
    func tapRegister(email: String,
                     password: String,
                     confirmPassword: String,
                     firstName: String,
                     lastName: String,
                     profileImageData: UIImage, 
                     registerType: RegisterType) {
        
        let isValid = registerValidation(email: email,
                                         password: password,
                                         confirmPassword: confirmPassword,
                                         firstName: firstName,
                                         lastName: lastName)
        if isValid {
            authManager.register(withEmail: email,
                                 password: password,
                                 firstname: firstName, 
                                 lastname: lastName,
                                 profileImageData: profileImageData)
            { result in
                switch result {
                case .success(_):
                    switch registerType {
                    case .programmatic:
                        self.delegate?.navigateToNextView()
                    case .storyboard:
                        self.delegate?.segueToNextView()
                    }
                case .failure(_):
                    self.delegate?.toggleAlert(messege: String(localized: "alert_register_failed"))
                }
            }
        }
    }
    
    func registerValidation(email: String,
                            password: String,
                            confirmPassword: String,
                            firstName: String,
                            lastName: String) -> Bool {
        
        guard email.isValidEmail() else {
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_email"))
            return false
        }
        
        guard password.isValidPassword() else {
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
