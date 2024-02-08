//
//  LoginStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import UIKit

class LoginStoryboardController: UIViewController {
    // MARK: - Varibles
    private let loginViewModel: LoginViewModel = LoginViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewModel.delegate = self
        self.tapToHideKeyboard()
    }
    
    // MARK: - Selectors
    @IBAction func didTapLoginButton(_ sender: Any) {
        guard let email = emailField.text,
              let password = passwordField.text else {
            return
        }

        loginViewModel.tapLogin(email: email, password: password, loginType: .storyboard)
    }
}

extension LoginStoryboardController: LoginViewModelDelegate {
    
    func toggleAlert(messege: String) {
        showAlert(message: messege)
    }

    func navigateToNextView() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.presentTabBarController()
    }
    
    func segueToNextView() {
        performSegue(withIdentifier: "LoginSuccess", sender: Any.self)
    }
    
}
