//
//  WebViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 23/1/2567 BE.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - UI Components
    let webView = WKWebView()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left" ), for: .normal)
        button.tintColor = UIColor.pinkPokemon
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
        self.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    func setupUI(){
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            webView.topAnchor.constraint(equalTo: backButton.topAnchor, constant: 40),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func loadWebView(){
        if let url = URL(string: "https://pokedex-nextzy.web.app/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // MARK: - Selectors
    @objc func didTapBackButton() {
        self.dismiss(animated: true, completion: nil)
    }

}
