//
//  LoginViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import UIKit
import AVFoundation
import AVKit

class LoginViewController: UIViewController {

    
    // MARK: - Varibles
    var player: AVPlayer?
    var playerViewController: AVPlayerViewController?
    
    private let authViewModel: AuthViewModel

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    lazy var logoImage: UIImageView = {
        let imageName = "pokedex-logo"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var emailField = LoginTextField(textfieldType: .email)
    
    lazy var passwordField = LoginTextField(textfieldType: .password)

    lazy var forgotPasswordButton = TextButton(title: String(localized: "forgot_password_button_text"))
    
    lazy var loginButton = CustomButton(title: String(localized: "login_button_text"), cornerRadius: 6)
    
    lazy var noAccountButton = TextButton(title: String(localized: "register_button_text"))
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // assign button function
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton(_:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        noAccountButton.addTarget(self, action: #selector(didTapRegisterButton(_:)), for: .touchUpInside)
        
    }
    
    // MARK: - UI Setup
    
    private func createLabelStackView(title: String, field: UITextField) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        
        let dividerLine = UIView()
        dividerLine.backgroundColor = UIColor(red: 0.941, green: 0.388, blue: 0.396, alpha: 1) // #f06365
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
           
        let labelStackView = UIStackView(arrangedSubviews: [label, field, dividerLine])
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        return labelStackView
    }
    
    private func createForgotPasswordButtonStackView() -> UIStackView {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [spacer, forgotPasswordButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }
    
    
    private func setupView() {
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "auth-video-bg", ofType: "mp4")!))
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        
        player.play()
        view.layer.addSublayer(layer)

        let verticalStackView = UIStackView(arrangedSubviews: [
            logoImage,
            createLabelStackView(title: String(localized: "email_label_text"), field: emailField),
            createLabelStackView(title: String(localized: "password_label_text"), field: passwordField),
            createForgotPasswordButtonStackView(),
            loginButton,
            noAccountButton
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 20
        
        self.view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: 300),
            logoImage.heightAnchor.constraint(equalToConstant: 95),
        ])
        
    }
    
    
    // MARK: - Selectors
    @objc private func didTapLoginButton(_ sender: UIButton) {
        
        // Check empty email and password
        guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !email.isEmpty,
              let password = passwordField.text,
              !password.isEmpty else {
            print("Debugger: Email or password is nil")
            showAlert(message: "Please enter email and password")
            return
        }
        if(authViewModel.isValidEmail(email)){
            if(authViewModel.isValidPassword(password)){
                Task {
                    do {
                        try await authViewModel.signIn(email: email, password: password)
                        print("Debugger: Login successful.")
                        self.showTabBarController()
                    } catch {
                        self.showAlert(message: "Wrong email or password")
                        print("Debugger: Login failed with error: \(error.localizedDescription)")
                    }
                }
                
            }else{
                showAlert(message: "Password must be at least 8 character")
            }
        }else{
            showAlert(message: "Invalid email")
        }
    }
    
    @objc private func didTapForgotPasswordButton(_ sender: UIButton){
        let forgotPasswordVC = ForgotViewController(authViewModel: authViewModel)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @objc private func didTapRegisterButton(_ sender: UIButton){
        let registerVC = RegisterViewController(authViewModel: authViewModel)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    // MARK: - Function
    
    private func showTabBarController() {
        print("DEBUG: showTabBarController()")
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.presentTabBarController()
    }

    
}
