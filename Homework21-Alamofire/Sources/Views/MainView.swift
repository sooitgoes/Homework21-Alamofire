//
//  MainView.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import UIKit

class MainView: UIView {

    // MARK: - UI Elements
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .systemGray
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var nameTextField: UITextField = {
        let txfld = UITextField()
        txfld.placeholder = "Type name"
        txfld.clipsToBounds = true
        txfld.layer.cornerRadius = 20
        txfld.backgroundColor = .white
        txfld.textAlignment = .center
        txfld.translatesAutoresizingMaskIntoConstraints = false
        return txfld
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        backgroundColor = .systemGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupHierarchy() {
        addSubViews(views: [nameTextField, searchButton, tableView])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalToConstant: 250),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),

            searchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
            searchButton.heightAnchor.constraint(equalToConstant: 44),

            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
