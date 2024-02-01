//
//  ForgotViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import UIKit

class ForgotViewController: UIViewController {
    
    // MARK: - Varibles
    private let authViewModel: AuthViewModel

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    lazy var emailTextfield = CustomTextField(textfieldType: .email)
    lazy var forgotButton: UIButton = {
        let button = CustomButton(title: String(localized: "forgot_password_title"))
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didTapForgotButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        authViewModel.delegate = self
    }
    
    // MARK: - UI Setup
    private func createLabelStackView(title: String, field: UITextField) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        
        let dividerLine = UIView()
        dividerLine.backgroundColor = UIColor.pinkPokemon
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
           
        let labelStackView = UIStackView(arrangedSubviews: [label, field, dividerLine])
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        return labelStackView
    }
    
    func setupNavbar(){
        self.title = String(localized: "forgot_password_title")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.pinkPokemon
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.pinkPokemon]
    }
    
    func setupUI(){
        setupNavbar()
        self.view.backgroundColor = .systemBackground
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            createLabelStackView(title: String(localized: "email_label_text"), field: emailTextfield),
            forgotButton
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 20
        
        self.view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: 300),
        ])
        
    }
    
    // MARK: - Selectors
    @objc func didTapForgotButton(_ sender: UIButton) {
        if let email = emailTextfield.text {
            authViewModel.tapForgotPassword(email: email)
        }
    }
    
}

extension ForgotViewController: AuthViewModelDelegate {
    func navigateToNextView() {
        
    }
    
    func setUserData(firstName: String, lastName: String, imageURL: String) {
        
    }
    
    func toggleAlert(messege: String) {
        self.showAlert(message: messege)
    }
    
}
