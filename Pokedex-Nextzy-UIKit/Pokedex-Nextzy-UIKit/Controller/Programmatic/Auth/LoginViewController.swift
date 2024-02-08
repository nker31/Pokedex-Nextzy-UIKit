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
    private let loginViewModel: LoginViewModel
    var player: AVPlayer?
    var playerViewController: AVPlayerViewController?

    // MARK: - Initializer
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        self.loginViewModel = LoginViewModel()
        super.init(coder: coder)
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

    lazy var forgotPasswordButton: UIButton = {
        let button = TextButton(title: String(localized: "forgot_password_button_text"))
        button.addTarget(self, action: #selector(didTapForgotPasswordButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = CustomButton(title: String(localized: "login_button_text"), cornerRadius: 6)
        button.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var noAccountButton: UIButton = {
        let button = TextButton(title: String(localized: "register_button_text"))
        button.addTarget(self, action: #selector(didTapRegisterButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // Storyboard
    @IBOutlet weak var emailFieldStoryboard: UITextField!
    @IBOutlet weak var passwordFieldStoryboard: UITextField!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewModel.delegate = self
        self.tapToHideKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }
    
    // MARK: - UI Setup
    
    private func createLabelStackView(title: String, field: UITextField) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        
        let dividerLine = UIView()
        dividerLine.backgroundColor = .pinkPokemon
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
        guard let email = emailField.text,
              let password = passwordField.text 
        else { return }
        
        loginViewModel.tapLogin(email: email, password: password, loginType: .programmatic)
    }
    
    @objc private func didTapForgotPasswordButton(_ sender: UIButton) {
        let forgotPasswordVC = ForgotViewController()
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @objc private func didTapRegisterButton(_ sender: UIButton) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    // Storyboard
    @IBAction func didTapLoginButtonStoryboard(_ sender: UIButton) {

        guard let email = emailFieldStoryboard.text,
              let password = passwordFieldStoryboard.text
        else { return }
        
        print("Debugger: Email = {\(email)} Password = {\(password)}")

        loginViewModel.tapLogin(email: email, password: password, loginType: .storyboard)
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    
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
