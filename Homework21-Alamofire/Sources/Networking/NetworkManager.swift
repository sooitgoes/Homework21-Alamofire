//
//  NetworkManager.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    let urlCards = "https://api.magicthegathering.io/v1/cards"
    
    func fetchCards(url: String, completion: @escaping (Result<Cards, Error>) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Cards.self) { data in
            switch data.result {
            case .success(let cards):
                completion(.success(cards))
            case .failure(let error):
                print("Failed to parse JSON:", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    func fetchImageForCell(urlImage: URL, completion: @escaping (Data) -> Void) {
        let request = AF.request(urlImage)
        request.responseData { data in
            guard let imageData = data.value else { return }
            completion(imageData)
        }
    }

// MARK: - Первый вариант задания со *
//    func fetchCardsByName(name: String, completion: @escaping (Result<DataCards, Error>) -> Void) {
//        let request = AF.request("https://api.magicthegathering.io/v1/cards?name=\(name)")
//        request.responseDecodable(of: Cards.self) { data in
//            switch data.result {
//            case .success(let cards):
//                cards.cards.forEach { element in
//                    completion(.success(element))
//                }
//            case .failure(let jsonError):
//                completion(.failure(jsonError))
//            }
//        }
//    }

    // MARK: - Второй вариант задания со *
    func fetchCardsByName(name: String, completion: @escaping (Result<[DataCards], Error>) -> Void) {
        let request = AF.request(urlCards)
        request.responseDecodable(of: Cards.self) { data in
            switch data.result {
            case .success(let cards):
                var searchCards = [DataCards]()
                cards.cards.forEach { element in
                    if element.name == name {
                        searchCards.append(element)
                        completion(.success(searchCards))
                    }
                }
            case .failure(let jsonError):
                completion(.failure(jsonError))
            }
        }
    }
}


