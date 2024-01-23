//
//  ProfileViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 22/1/2567 BE.
//

import UIKit
import WebKit

class ProfileViewController: UIViewController {
    
    
    
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
    lazy var coverScreenView = UIView()
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var userFullnameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
        
    }()
    
    lazy var profileImageView: UIImageView = {
        let image = UIImage(named: "pokeball-profile")
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
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

        
        coverScreenView.backgroundColor = UIColor.pinkPokemon
        tableView.backgroundColor = UIColor.pinkPokemon.withAlphaComponent(0.2)
        tableView.separatorStyle = .none
        
        profileImageView.layer.cornerRadius = (view.frame.width / 3) / 2
        profileImageView.clipsToBounds = true

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

    // MARK: - Selectors
    
}

    // MARK: -

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    // number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    // row element
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Edit profile"
            cell.imageView?.image = UIImage(systemName: "pencil")
            cell.imageView?.tintColor = UIColor.pinkPokemon
            cell.textLabel?.textColor = UIColor.pinkPokemon
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Terms and Conditions"
            cell.imageView?.image = UIImage(systemName: "chart.bar.doc.horizontal.fill")
            cell.imageView?.tintColor = UIColor.pinkPokemon
            cell.textLabel?.textColor = UIColor.pinkPokemon
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
        } else {
            // Create a custom cell for the button
            let buttonCell = UITableViewCell(style: .default, reuseIdentifier: nil)
            buttonCell.backgroundColor = UIColor.pinkPokemon.withAlphaComponent(0)
            
            let button = UIButton(type: .system)
            button.setTitle("Sign Out", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor.pinkPokemon
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
            
            buttonCell.contentView.addSubview(button)
            
            // Add constraints for the button
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: buttonCell.contentView.topAnchor, constant: 30),
                button.leadingAnchor.constraint(equalTo: buttonCell.contentView.leadingAnchor, constant: 15),
                button.trailingAnchor.constraint(equalTo: buttonCell.contentView.trailingAnchor, constant: -15),
                button.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            return buttonCell
        }
        
        return cell
    }
    
    // routing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            showAlert(message: "tab edit profile")
        }else if indexPath.row == 1{
            showAlert(message: "tab term and condition")
        }
    }

    // Target action for the sign-out button
    @objc func signOutButtonTapped() {
        authViewModel.signOut()
        showAlert(message: "Sign out completed")
        displayLogin()
    }
    func displayLogin() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.presentLoginViewController()
    }
}

