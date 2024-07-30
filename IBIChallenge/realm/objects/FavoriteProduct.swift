//
//  FavoriteProduct.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 30/07/2024.
//

import Foundation
import RealmSwift

class FavoriteProduct: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var price: Double
    @Persisted var thumbnail: String
    
    convenience init(id: Int, title: String, price: Double, thumbnail: String) {
        self.init()
        
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
    }
    
    var formattedPrice: String {
        String(format: "$%.2f", self.price)
    }

}
