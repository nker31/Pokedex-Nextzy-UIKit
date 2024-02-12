//
//  PresentionSytleController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 6/2/2567 BE.
//

import UIKit

class PresentionSytleController: UIViewController {
    let authManager: AuthenticationManager = AuthenticationManager.shared
    
    var programmaticButton: UIButton = {
        let button = UIButton()
        button.setTitle("Programmatic UI", for: .normal)
        button.addTarget(self, action: #selector(presentProgrammaticUI), for: .touchUpInside)
        return button
    }()
    
    var storyboardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Storyboard UI", for: .normal)
        button.addTarget(self, action: #selector(presentStoryboardUI), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .pinkPokemon
        view.addSubview(programmaticButton)
        view.addSubview(storyboardButton)
        
        programmaticButton.translatesAutoresizingMaskIntoConstraints = false
        storyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            programmaticButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            programmaticButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            storyboardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            storyboardButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
        ])
    }
    
    @objc func presentProgrammaticUI() {
        let vc: UIViewController
        if authManager.userSession != nil {
            vc = TabBarController()
        } else {
            vc = UINavigationController(rootViewController: LoginViewController(loginViewModel: LoginViewModel()))
        }
        let programmaticViewController = vc
        programmaticViewController.modalPresentationStyle = .fullScreen
        self.present(programmaticViewController, animated: true)
        
    }
    
    @objc func presentStoryboardUI() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if authManager.userSession != nil {
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarStoryboardController
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true)
        } else {
            guard let storyboardViewController = storyboard.instantiateInitialViewController() else {
                return
            }
            storyboardViewController.modalPresentationStyle = .fullScreen
            present(storyboardViewController, animated: true)
        }
    }

}
