//
//  StatBar.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 26/1/2567 BE.
//

import UIKit

class StatBar: UIView {
    // MARK: - Varibles
    var title: String
    var stat: Int
    var maxStat: Int

    init(label: String, stat: Int, maxStat: Int = 100) {
        self.title = label
        self.stat = stat
        self.maxStat = maxStat
        super.init(frame: .zero)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .notoSansMedium(size: 14)
        return label
    }()

    var statLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSansSemiBold(size: 14)
        return label
    }()
    
    var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(red: 0.357, green: 0.678, blue: 0.925, alpha: 1) // #5badec
        progressView.trackTintColor = .lightGray.withAlphaComponent(0.4)
        return progressView
    }()

    // MARK: - UI Setup
    func setupUI() {
        titleLabel.text = title
        statLabel.text = "\(stat)"
        
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            statLabel,
            progressBar
        ])
        
        stack.axis = .horizontal
        stack.spacing = 10
        self.addSubview(stack)
        
        let progressValue = Float(stat) / Float(maxStat)
        progressBar.progress = progressValue

        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
}
