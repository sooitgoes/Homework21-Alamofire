//
//  DetailView.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import UIKit

class DetailView: UIView {

    // MARK: - UI Elements
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupHierarchy() {
        addSubViews(views: [nameLabel, descriptionLabel])
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
        ])
    }
}



