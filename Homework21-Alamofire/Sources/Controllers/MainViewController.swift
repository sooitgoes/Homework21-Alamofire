//
//  MainViewController.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import UIKit

class MainViewController: UIViewController {
    let networkManager = NetworkManager()
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
        fetchCards()
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

    private func fetchCards() {
        networkManager.fetchCards(url: networkManager.urlCards) { [weak self] result in
            switch result {
            case .success(let cards):
                self?.allCards = cards.cards
                self?.mainView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Action

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell else { return UITableViewCell() }
        let cardCell = allCards[indexPath.row]
        cell.cards = cardCell

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        viewController.detailsOfCard = allCards[indexPath.row]
        present(viewController, animated: true)
    }
}

