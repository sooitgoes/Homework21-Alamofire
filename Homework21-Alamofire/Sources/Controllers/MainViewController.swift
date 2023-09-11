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
        mainView.searchButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
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
    @objc func buttonPressed() {
            // Первый вариант

//        networkManager.fetchCardsByName(name: mainView.textField.text ?? "") { [weak self] result in
//            switch result {
//            case .success(let card):
//                self?.allCards.append(card)
//                self?.mainView.tableView.reloadData()
//            case .failure(_):
//                self?.showAlert(title: "Not found: 404", message: "Please try again.")
//            }
//        }

          // Второй вариант
        mainView.nameTextField.text?.isEmpty == true ?
        showAlert(title: "Empty field", message: "Please enter the name of the card.")
        :
        networkManager.fetchCardsByName(name: mainView.nameTextField.text ?? "") { [weak self] result in
            switch result {
            case .success(let card):
                self?.allCards = card
                self?.mainView.tableView.reloadData()
            case .failure(_):
                self?.showAlert(title: "Not found: 404", message: "Please try again.")
            }
        }
    }
}

// MARK: - UITableViewDataSource
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

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        viewController.detailsOfCard = allCards[indexPath.row]
        present(viewController, animated: true)
    }
}

// MARK: - Alert
extension MainViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}


