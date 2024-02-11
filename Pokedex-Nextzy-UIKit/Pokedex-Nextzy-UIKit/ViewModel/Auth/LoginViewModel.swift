//
//  LoginViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func toggleAlert(messege: String)
    func navigateToNextView()
    func segueToNextView()
}

class LoginViewModel {
    
    enum LoginType {
        case programmatic
        case storyboard
    }
    
    // MARK: - Variables
    private let authManager = AuthenticationManager.shared
    weak var delegate: LoginViewModelDelegate?

    // MARK: - Method
    func tapLogin(email: String, password: String, loginType: LoginType) {
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
                    switch loginType {
                    case .programmatic:
                        self.delegate?.navigateToNextView()
                    case .storyboard:
                        self.delegate?.segueToNextView()
                    }
                }
            } catch {
                print("Debugger: Sign in failed")
                DispatchQueue.main.async {
                    self.delegate?.toggleAlert(messege: String(localized: "alert_login_failed"))
                }
            }
        }
    }
    
}
