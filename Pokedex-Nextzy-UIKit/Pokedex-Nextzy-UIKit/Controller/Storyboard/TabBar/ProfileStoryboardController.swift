//
//  ProfileStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 9/2/2567 BE.
//

import UIKit

class ProfileStoryboardController: UIViewController {

    // MARK: - Varibles
    private let profileViewModel: ProfileViewModel = ProfileViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userFullnameLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        profileViewModel.getProfileData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewModel.delegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Selectors
    @IBAction func didTapSignOutButton(_ sender: Any) {
        profileViewModel.tapSignOut(signOutType: .storyboard)
    }
}

extension ProfileStoryboardController: ProfileViewModelDelegate {
    func segueToNextView() {
        performSegue(withIdentifier: "SignOutSuccess", sender: Any.self)
    }
    
    func setProfileData(firstName: String, lastName: String, imageURL: String) {
        userFullnameLabel.text = "\(firstName) \(lastName)"
        profileImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "pokeball-profile"))
        
    }
    
    func navigateToNextView() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.presentLoginViewController()
    }

}
