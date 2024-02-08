//
//  WebViewStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 9/2/2567 BE.
//

import UIKit
import WebKit

class WebViewStoryboardController: UIViewController {
    
    // MARK: - UI Components
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    // MARK: - UI Setup
    func loadWebView() {
        guard let url = URL(string: "https://pokedex-nextzy.web.app/") else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - Selectors
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
