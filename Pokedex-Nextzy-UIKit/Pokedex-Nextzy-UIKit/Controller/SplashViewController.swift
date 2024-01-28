//
//  SplashViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 28/1/2567 BE.
//

import UIKit

class SplashViewController: UIViewController {
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pokeball-logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.animateLogo()
    }
    
    // MARK: - UI Setup
    func setupUI(){
        view.backgroundColor = UIColor.pinkPokemon
        
        view.addSubview(logoImageView)
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            self.logoImageView.widthAnchor.constraint(equalToConstant: 120),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 120)
            
        ])
    }
    
    private func animateLogo() {

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.logoImageView.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 1.3, options: .curveEaseOut, animations: {
                self.logoImageView.transform = CGAffineTransform(scaleX: 10.0, y: 10.0)
                self.logoImageView.alpha = 0.2
            })
        })
    }
    


}
