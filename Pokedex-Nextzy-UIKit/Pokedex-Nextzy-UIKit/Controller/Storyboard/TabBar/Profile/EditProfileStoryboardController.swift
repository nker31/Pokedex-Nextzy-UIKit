//
//  EditProfileStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 9/2/2567 BE.
//

import UIKit

class EditProfileStoryboardController: UIViewController {

    // MARK: - Varibles
    private let editProfileViewModel: EditProfileViewModel = EditProfileViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    let imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavbar()
        editProfileViewModel.getProfileData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileViewModel.delegate = self
        imagePicker.delegate = self
        tapToHideKeyboard()
    }
    
    // MARK: - UI Setup
    private func setupNavbar(){
        self.title = String(localized: "edit_profile_title")
        guard let nav = navigationController?.navigationBar else {
            return
        }
        nav.tintColor = .white
        nav.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.prefersLargeTitles = true
    }
    
    // MARK: - Selectors
    @IBAction func didTapImagePickerStoryboard(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func didTapUpdateButtonStoryboard(_ sender: Any) {
        guard let firstName = firstnameField.text,
              let lastName = lastnameField.text,
              let newImage = profileImageView.image else{
            print("Debugger: error from tap update button")
            return
        }
        editProfileViewModel.tapUpdate(firstName: firstName,
                                lastName: lastName,
                                newImage: newImage)
    }

}

extension EditProfileStoryboardController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

extension EditProfileStoryboardController: EditProfileViewModelDelegate {
    
    func setProfileData(firstName: String, lastName: String, imageURL: String) {
        self.firstnameField.text = firstName
        self.lastnameField.text = lastName
        self.profileImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "pokeball-profile"))
    }
    
    func toggleAlert(messege: String) {
        self.showAlert(message: messege)
    }
}

