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
    private let cellTitle: [String] = [String(localized: "edit_profile_title"),
                                       String(localized: "terms_and_conditions_title"),
                                       String(localized: "language_setting_title")]
    
    // MARK: - UI Components
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userFullnameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        profileViewModel.getProfileData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Selectors
    @IBAction func didTapSignOutButton(_ sender: Any) {
        profileViewModel.tapSignOut(signOutType: .storyboard)
    }
    
    func configureCell(cell: UITableViewCell, rowIndex: Int) {
        cell.textLabel?.text = cellTitle[rowIndex]
        cell.textLabel?.textColor = .pinkPokemon
        
    }
}

extension ProfileStoryboardController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configureCell(cell: cell, rowIndex: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "PresentEditProfile", sender: nil)
            case 1:
                performSegue(withIdentifier: "PresentWebView", sender: nil)
            case 2:
                performSegue(withIdentifier: "PresentSetting", sender: nil)
            default:
                break
            }
    }
}

extension ProfileStoryboardController: ProfileViewModelDelegate {
    func segueToNextView() {
        hidesBottomBarWhenPushed = true
        performSegue(withIdentifier: "SignOutSuccess", sender: Any.self)
    }
    
    func setProfileData(firstName: String, lastName: String, imageURL: String) {
        userFullnameLabel.text = "\(firstName) \(lastName)"
        profileImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "pokeball-profile"))
        
    }
    
    func navigateToNextView() {
        
    }

}
