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
    lazy var coverScreenView = UIView()
    lazy var profileImageView: UIImageView = {
        let imageName = "pokeball-profile"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    // Image picker
    lazy var imagePickerButton = ImagePickerButton()
    let imagePicker = UIImagePickerController()
    
    // Textfield 
    let firstnameTextfield = CustomTextField(textfieldType: .firstname)
    let lastnameTextfield = CustomTextField(textfieldType: .lastname)
    
    // Button
    let updateButton = CustomButton(title: "Update")
    
    private func createLabelStackView(title: String, field: UITextField) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.gray
        
        let dividerLine = UIView()
        dividerLine.backgroundColor = UIColor.pinkPokemon // #f06365
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
           
        let labelStackView = UIStackView(arrangedSubviews: [label, field, dividerLine])
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        return labelStackView
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let imageURL = authViewModel.currentUser?.profileImageURL{
            profileImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "pokeball-profile"))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavbar()
        imagePicker.delegate = self
        imagePickerButton.addTarget(self, action: #selector(didTapPhotoButton), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        // Make sure to set up the text fields after calling setupUI()
        firstnameTextfield.text = authViewModel.currentUser?.firstname ?? "John"
        lastnameTextfield.text = authViewModel.currentUser?.lastname ?? "Doe"
    }
    
    // MARK: - UI Setup
    private func setupNavbar(){
        self.title = "Edit my profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    private func setupUI(){
        self.view.backgroundColor = .white
        let textfieldStack = UIStackView(arrangedSubviews: [
            createLabelStackView(title: "Firstname", field: firstnameTextfield),
            createLabelStackView(title: "Lastname", field: lastnameTextfield),
            
        ])
        
        
        
        
        self.view.addSubview(coverScreenView)
        coverScreenView.backgroundColor = UIColor.pinkPokemon // #f06365
        coverScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 60
        
        self.view.addSubview(imagePickerButton)
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        imagePickerButton.layer.cornerRadius = 15
        

        
        
        textfieldStack.axis = .vertical
        textfieldStack.spacing = 15
        self.view.addSubview(textfieldStack)
        textfieldStack.translatesAutoresizingMaskIntoConstraints = false
        textfieldStack.backgroundColor = .white
        
        self.view.addSubview(updateButton)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.layer.cornerRadius = 20
        
        
        NSLayoutConstraint.activate([
            coverScreenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverScreenView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
            coverScreenView.widthAnchor.constraint(equalTo: view.widthAnchor),
            coverScreenView.heightAnchor.constraint(equalToConstant: 280),
            
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: coverScreenView.bottomAnchor, constant: -20),
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
        Task{
            await authViewModel.editUserData(firstname: firstName, lastname: lastName, profileImageData: newImage) { result in
                switch result {
                case .success(_):
                    self.showAlert(message: "update successfully")
                    self.dismiss(animated: true)
                    
                case .failure(_):
                    self.showAlert(message: "update failed")
                }
            }
        }
        
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
