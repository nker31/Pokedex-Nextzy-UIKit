//
//  RegisterStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import UIKit

class RegisterStoryboardController: UIViewController {

    // MARK: - Varibles
    private let registerViewModel: RegisterViewModel = RegisterViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    let imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        registerViewModel.delegate = self
        imagePicker.delegate = self
        tapToHideKeyboard()
    }
    
    // MARK: - UI Setup
    private func setupNavbar() {
        self.title = String(localized: "register_title")
        guard let nav = self.navigationController?.navigationBar else {
            return
        }
        nav.prefersLargeTitles = true
        nav.tintColor = .white
        nav.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // MARK: - Selectors
    @IBAction func dipTapRegisterButtonStoryboard(_ sender: UIButton) {
        print("Debugger: register Storyboard tapped")
        guard let email = emailField.text,
              let password = passwordField.text,
              let confirmPassword = confirmPasswordField.text,
              let firstName = firstnameField.text,
              let lastName = lastnameField.text,
              let profileImage = profileImageView.image else {
                  return
              }
        
        registerViewModel.tapRegister(email: email,
                                      password: password,
                                      confirmPassword: confirmPassword,
                                      firstName: firstName,
                                      lastName: lastName,
                                      profileImageData: profileImage,
                                      registerType: .storyboard)
    }
    
    @IBAction func didTapImagePicker(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }

}

extension RegisterStoryboardController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension RegisterStoryboardController: RegisterViewModelDelegate {
    func segueToNextView() {
        performSegue(withIdentifier: "RegisterSuccess", sender: Any.self)
    }
    
    func toggleAlert(messege: String) {
        showAlert(message: messege)
    }
    
    func navigateToNextView() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.presentTabBarController()
    }
}
