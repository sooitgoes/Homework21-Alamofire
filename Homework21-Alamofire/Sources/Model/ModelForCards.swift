//
//  ModelForCards.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import Foundation

struct Cards: Decodable {
    let cards: [DataCards]
}

struct DataCards: Decodable {
    let name: String?
    let cmc: Int?
    let imageUrl: String?
    let id: String?
    let text: String?
}
