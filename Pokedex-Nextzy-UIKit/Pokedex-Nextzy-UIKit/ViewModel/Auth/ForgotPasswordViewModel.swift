//
//  ForgotPasswordViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation

protocol ForgotPasswordViewModelDelegate: AnyObject {
    func toggleAlert(messege: String)
}

class ForgotPasswordViewModel {
    
    // MARK: - Variables
    private let authManager = AuthenticationManager.shared
    weak var delegate: ForgotPasswordViewModelDelegate?
    
    // MARK: - Method
    func tapResetPassword(email: String) {
        guard authManager.isValidEmail(email) else {
            delegate?.toggleAlert(messege: String(localized: "alert_invalid_email"))
            return
        }
        
        authManager.resetPassword(withEmail: email) { result in
            switch result {
            case .success(_):
                self.delegate?.toggleAlert(messege: String(localized: "alert_reset_success"))
            case .failure(_):
                self.delegate?.toggleAlert(messege: String(localized: "alert_reset_failed"))
            }
        }
    }

}
