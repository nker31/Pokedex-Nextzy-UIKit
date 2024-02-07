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
        view.backgroundColor = .red
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
        print("Debugger: Programmatic")
        if (authManager.currentUser != nil) {
            
        } else {
            
        }
        let vc = LoginViewController(loginViewModel: LoginViewModel())
        let programmaticViewController =  UINavigationController(rootViewController: vc)
        programmaticViewController.modalPresentationStyle = .fullScreen
        self.present(programmaticViewController, animated: true)
        
    }
    
    @objc func presentStoryboardUI() {
        print("Debugger: Storyboard")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let storyboardViewController = storyboard.instantiateInitialViewController() {
            storyboardViewController.modalPresentationStyle = .fullScreen
            present(storyboardViewController, animated: true)
        } else {
            print("Debugger: Unable to instantiate initial view controller from storyboard")
        }
        
    }

}
