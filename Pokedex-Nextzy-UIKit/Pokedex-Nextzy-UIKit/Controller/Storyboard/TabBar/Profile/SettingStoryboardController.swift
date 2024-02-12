//
//  SettingStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 9/2/2567 BE.
//

import UIKit

class SettingStoryboardController: UIViewController {

    // MARK: - Varibles
    let settingViewModel: SettingViewModel = SettingViewModel()
    let languages: [String] = ["English", "ภาษาไทย",]
    let languageCodes: [String] = ["en", "th",]
    
    // MARK: - UI Components
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        settingViewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UI Setup
    func setupNav() {
        title = String(localized: "language_setting_title")
        guard let nav = navigationController?.navigationBar else {
            return
        }
        nav.tintColor = .pinkPokemon
        nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.pinkPokemon]
        nav.prefersLargeTitles = false
    }
    
    // MARK: - Selectors
    func configureCell(cell: UITableViewCell, rowIndex: Int) {
        cell.textLabel?.text = languages[rowIndex]
        cell.textLabel?.textColor = .pinkPokemon
        
        if let selectedLanguageCode = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as? String,
            let selectedLanguageIndex = languageCodes.firstIndex(of: selectedLanguageCode),
            selectedLanguageIndex == rowIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}

extension SettingStoryboardController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configureCell(cell: cell, rowIndex: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguageCode = languageCodes[indexPath.row]
        settingViewModel.switchLanguage(languageCode: selectedLanguageCode)
    }
}

extension SettingStoryboardController: SettingViewModelDelegate {
    func toggleAlert(messege: String) {
        showAlert(message: messege)
    }
    
    func toggleViewReload() {
        tableView.reloadData()
    }
}
