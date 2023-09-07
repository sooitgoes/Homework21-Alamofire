//
//  CardCell.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import UIKit

class CardCell: UITableViewCell {
    static let identifier = "cardCell"
    let networkManager = NetworkManager()

    var cards: DataCards? {
        didSet {
            nameLabel.text = cards?.name
            cmcLabel.text = "CMC -> \(cards?.cmc ?? 0)"
            idLabel.text = "ID -> \(cards?.id ?? "")"

            guard let imagePath = cards?.imageUrl,
                  let urlImage = URL(string: imagePath)
            else {
                imageCard.image = UIImage(named: "404")
                return
            }
            networkManager.fetchImageForCell(urlImage: urlImage) { [weak self] data in
                self?.imageCard.image = UIImage(data: data)
            }
        }
    }

    // MARK: - UI Elements
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private lazy var cmcLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()

    private lazy var stackLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var imageCard: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupHierarchy() {
        stackLabel.addArrangedSubview(nameLabel)
        stackLabel.addArrangedSubview(cmcLabel)
        stackLabel.addArrangedSubview(idLabel)
        contentView.addSubViews(views: [stackLabel, imageCard])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            stackLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),

            imageCard.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageCard.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            imageCard.heightAnchor.constraint(equalToConstant: 75),
            imageCard.widthAnchor.constraint(equalToConstant: 55)
        ])
        stackLabel.setCustomSpacing(5, after: nameLabel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.cards = nil
    }
}
