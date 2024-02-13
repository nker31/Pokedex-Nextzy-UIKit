//
//  ForgotStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import UIKit

class ForgotStoryboardController: UIViewController {
    // MARK: - Varibles
    let forgotViewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var emailField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotViewModel.delegate = self
        tapToHideKeyboard()
        setupNavbar()
    }
    
    // MARK: - UI Setup
    func setupNavbar() {
        self.title = String(localized: "forgot_password_title")
        guard let nav = navigationController?.navigationBar else { return }
        nav.prefersLargeTitles = true
        nav.tintColor = UIColor.pinkPokemon
        nav.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.pinkPokemon]
    }
    
    // MARK: - Selectors
    @IBAction func didTapForgotButton(_ sender: Any) {
        guard let email = emailField.text else {
            return
        }
        forgotViewModel.tapResetPassword(email: email)
    }

}

extension ForgotStoryboardController: ForgotPasswordViewModelDelegate {
    func toggleAlert(messege: String) {
        showAlert(message: messege)
    }
}
