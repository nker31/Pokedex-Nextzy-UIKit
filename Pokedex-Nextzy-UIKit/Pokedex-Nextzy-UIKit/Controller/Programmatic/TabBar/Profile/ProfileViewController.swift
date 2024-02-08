//
//  ProfileViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 22/1/2567 BE.
//

import UIKit
import WebKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    // MARK: - Varibles
    private let profileViewModel: ProfileViewModel = ProfileViewModel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI Components
    lazy var coverScreenView: UIView = {
        let view = UIView()
        view.backgroundColor = .pinkPokemon
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .pinkPokemon.withAlphaComponent(0.2)
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var userFullnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .notoSansSemiBold(size: 20)
        return label
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = (view.frame.width / 3) / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized: "sign_out_button_text"), for: .normal)
        button.titleLabel?.font = .notoSansSemiBold(size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .pinkPokemon
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        profileViewModel.getProfileData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        profileViewModel.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        view.addSubview(coverScreenView)
        view.addSubview(profileImageView)
        view.addSubview(userFullnameLabel)
        view.addSubview(tableView)

        coverScreenView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userFullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coverScreenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverScreenView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
            coverScreenView.widthAnchor.constraint(equalTo: view.widthAnchor),
            coverScreenView.heightAnchor.constraint(equalToConstant: 280),
            
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: userFullnameLabel.topAnchor, constant: -10),
            profileImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            userFullnameLabel.centerXAnchor.constraint(equalTo: coverScreenView.centerXAnchor),
            userFullnameLabel.bottomAnchor.constraint(equalTo: coverScreenView.bottomAnchor, constant: -25),
            
            tableView.topAnchor.constraint(equalTo: coverScreenView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    func configureCell(_ cell: UITableViewCell, imageName: String) {
        cell.imageView?.image = UIImage(systemName: imageName)
        cell.imageView?.tintColor = .pinkPokemon
        cell.textLabel?.textColor = .pinkPokemon
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
    }
    
    // MARK: - Selector
    @objc func didTapSignOutButton() {
        profileViewModel.tapSignOut(signOutType: .programmatic)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    // row element
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = String(localized: "edit_profile_title")
            configureCell(cell, imageName: "pencil")
        } else if indexPath.row == 1 {
            cell.textLabel?.text = String(localized: "terms_and_conditions_title")
            configureCell(cell, imageName: "chart.bar.doc.horizontal.fill")
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Language Setting"
            configureCell(cell, imageName: "globe.americas.fill")
        } else {
            let buttonCell = UITableViewCell(style: .default, reuseIdentifier: nil)
            buttonCell.backgroundColor = .clear
            buttonCell.contentView.addSubview(signOutButton)
            
            signOutButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                signOutButton.topAnchor.constraint(equalTo: buttonCell.contentView.topAnchor, constant: 30),
                signOutButton.leadingAnchor.constraint(equalTo: buttonCell.contentView.leadingAnchor, constant: 15),
                signOutButton.trailingAnchor.constraint(equalTo: buttonCell.contentView.trailingAnchor, constant: -15),
                signOutButton.heightAnchor.constraint(equalToConstant: 40)
            ])
            return buttonCell
        }
        return cell
    }
    
    // navigate to selected viewcontroller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let editProfileController = EditProfileViewController()
            self.navigationController?.pushViewController(editProfileController, animated: true)
            
        } else if indexPath.row == 1 {
            let webViewController = WebViewController()
            self.present(webViewController, animated: true)
        } else if indexPath.row == 2 {
            let settingController = SettingsViewController()
            self.navigationController?.pushViewController(settingController, animated: true)
        }
    }
    
}

extension ProfileViewController: ProfileViewModelDelegate {
    func segueToNextView() {
        
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
