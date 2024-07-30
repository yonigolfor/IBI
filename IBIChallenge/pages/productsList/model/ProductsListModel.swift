//
//  ProductsListModel.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import Foundation

struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let brand: String?
    let thumbnail: String
    let images: [String]?
    
    var formattedPrice: String {
         String(format: "$%.2f", self.price)
     }
}

struct ProductsReponse: Codable {
    var products: [Product]
}
