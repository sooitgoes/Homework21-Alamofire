//
//  MainViewController.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import UIKit

class MainViewController: UIViewController {
    var allCards = [DataCards]()

    // MARK: - Ui Elements
    let mainView = MainView()

    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerTableCell()
        viewConfiguration()
    }

    // MARK: - Configuration

    private func setupNavigationBar() {
        title = "Magic: The Gathering"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func viewConfiguration() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self

    }

    private func registerTableCell() {
        mainView.tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
    }

    // MARK: - Action

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell else { return UITableViewCell() }
//        let cardCell = allCards[indexPath.row]
//        cell.cards = cardCell

        return cell
    }


}

extension MainViewController: UITableViewDelegate {

}

