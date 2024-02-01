//
//  EditProfileViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 23/1/2567 BE.
//

import UIKit

class EditProfileViewController: UIViewController {

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
    // Profile image and cover
    lazy var coverScreenView: UIView = {
        let view = UIView()
        view.backgroundColor = .pinkPokemon
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageName = "pokeball-profile"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 60
        return imageView
    }()
    
    // Image picker
    lazy var imagePickerButton: ImagePickerButton = {
        let button = ImagePickerButton()
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapPhotoButton), for: .touchUpInside)
        return button
    }()
    let imagePicker = UIImagePickerController()
    
    // Textfield 
    let firstnameTextfield = CustomTextField(textfieldType: .firstname)
    let lastnameTextfield = CustomTextField(textfieldType: .lastname)
    
    // Button
    let updateButton: UIButton = {
        let button = CustomButton(title: String(localized: "update_button_text"))
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        return button
    }()
    
    // text field row
    private func createLabelStackView(title: String, field: UITextField) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        
        let dividerLine = UIView()
        dividerLine.backgroundColor = .pinkPokemon // #f06365
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
           
        let labelStackView = UIStackView(arrangedSubviews: [label, field, dividerLine])
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        return labelStackView
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        authViewModel.delegate = self
        imagePicker.delegate = self
        
        setupUI()
        setupNavbar()
        authViewModel.getProfileData()
    }
    
    // MARK: - UI Setup
    private func setupNavbar(){
        self.title = String(localized: "edit_profile_title")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupUI(){
        self.view.backgroundColor = .white
        
        let textfieldStack = UIStackView(arrangedSubviews: [
            createLabelStackView(title: String(localized: "first_name_label_text"), field: firstnameTextfield),
            createLabelStackView(title: String(localized: "last_name_label_text"), field: lastnameTextfield),
        ])
         
        self.view.addSubview(coverScreenView)
        coverScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(imagePickerButton)
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        
        textfieldStack.axis = .vertical
        textfieldStack.spacing = 15
        self.view.addSubview(textfieldStack)
        textfieldStack.translatesAutoresizingMaskIntoConstraints = false
        textfieldStack.backgroundColor = .white
        
        self.view.addSubview(updateButton)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverScreenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverScreenView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
            coverScreenView.widthAnchor.constraint(equalTo: view.widthAnchor),
            coverScreenView.heightAnchor.constraint(equalToConstant: 280),
            
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: coverScreenView.bottomAnchor, constant: -15),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            imagePickerButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -30),
            imagePickerButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0),
            imagePickerButton.widthAnchor.constraint(equalToConstant: 30),
            imagePickerButton.heightAnchor.constraint(equalToConstant: 30),
            
            textfieldStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textfieldStack.topAnchor.constraint(equalTo: coverScreenView.bottomAnchor, constant: 20),
            textfieldStack.widthAnchor.constraint(equalToConstant: 320),
            
            updateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor ),
            updateButton.topAnchor.constraint(equalTo: textfieldStack.bottomAnchor, constant: 30),
            updateButton.widthAnchor.constraint(equalToConstant: 320),
            updateButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapPhotoButton(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func didTapUpdateButton(){
        guard let firstName = firstnameTextfield.text,
              let lastName = lastnameTextfield.text,
              let newImage = profileImageView.image else{
            print("Debugger: error from tap update button")
            return
        }
        authViewModel.tapUpdate(firstName: firstName,
                                lastName: lastName,
                                newImage: newImage)
    
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension EditProfileViewController: AuthViewModelDelegate {
    func navigateToNextView() {
    }
    
    func setUserData(firstName: String, lastName: String, imageURL: String) {
        self.firstnameTextfield.text = firstName
        self.lastnameTextfield.text = lastName
        self.profileImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "pokeball-profile"))
    }
    
    func toggleAlert(messege: String) {
        self.showAlert(message: messege)
    }
}
