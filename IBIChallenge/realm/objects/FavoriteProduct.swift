//
//  FavoriteProduct.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 30/07/2024.
//

import Foundation
import RealmSwift
import CryptoKit


class FavoriteProduct: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var encryptedPriceData: Data
    @Persisted var thumbnail: String
    
    private let encryptionManager = EncryptionManager()

    // Computed property for accessing the decrypted price
       var price: Double {
           get {
               guard let decryptedPriceString = encryptionManager.decryptPassword(encryptedData: encryptedPriceData),
                     let decryptedPrice = Double(decryptedPriceString) else {
                   return 0.0 // Default value if decryption fails
               }
               return decryptedPrice
           }
           set {
               let priceString = String(newValue)
               if let (_, encryptedData) = encryptionManager.encryptPassword(password: priceString) {
                   encryptedPriceData = encryptedData
               }
           }
       }
    
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
