//
//  WebViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 23/1/2567 BE.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI Components
    let webView = WKWebView()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left" ), for: .normal)
        button.tintColor = UIColor.pinkPokemon
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    // Storyboard
    @IBOutlet weak var webViewStoryboard: WKWebView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
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
    
    func loadWebView() {
        guard let url = URL(string: "https://pokedex-nextzy.web.app/") else {
            return
        }
        
        let request = URLRequest(url: url)
        
        if let webView = webViewStoryboard {
            webView.load(request)
        } else {
            webView.load(request)
        }
    }
    
    // MARK: - Selectors
    @objc func didTapBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapBackButtonStoryboard(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
