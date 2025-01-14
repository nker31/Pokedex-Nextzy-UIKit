//
//  LoginViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation

protocol LoginViewModelDelegate {
    func toggleAlert(messege: String)
    func navigateToNextView()
}

class LoginViewModel {
    
    // MARK: - Variables
    private let authManager = AuthenticationManager.shared
    var delegate: LoginViewModelDelegate?
    
    // MARK: - Initializer
    
    // MARK: - Method
    func tapLogin(email: String, password: String) {
        guard authManager.isValidEmail(email) else {
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_email"))
            return
        }
        
        guard authManager.isValidPassword(password) else {
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_password"))
            return
        }
        
        Task {
            do {
                try await authManager.signIn(email: email, password: password)
                print("Debugger: Sign in success")
                DispatchQueue.main.async {
                    self.delegate?.navigateToNextView()
                }
            } catch {
                print("Debugger: Sign in failed")
                delegate?.toggleAlert(messege: String(localized: "alert_login_failed"))
            }
        }
    }
    
}
