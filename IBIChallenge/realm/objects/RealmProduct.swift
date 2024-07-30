//
//  RealmProduct.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 30/07/2024.
//

import Foundation
import RealmSwift

class RealmProduct: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var productDescription: String
    @Persisted var price: Double
    @Persisted var brand: String?
    @Persisted var thumbnail: String
}

