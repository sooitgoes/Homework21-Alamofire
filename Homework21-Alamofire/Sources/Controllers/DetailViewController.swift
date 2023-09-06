//
//  DetailViewController.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import UIKit

class DetailViewController: UIViewController {
    var detailsOfCard: DataCards? {
        didSet {
            detailView.nameLabel.text = detailsOfCard?.name
            detailView.descriptionLabel.text = detailsOfCard?.text
        }
    }

    // MARK: - Ui Elements
    let detailView = DetailView()

    // MARK: - Lifecycle
    override func loadView() {
        view = detailView
    }
}
