//
//  NewProductsFormViewModel.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 30/07/2024.
//

import Foundation

@Observable
class NewProductsFormViewModel {
    var id: Int
    var title: String
    var description: String
    var price: String
    var brand: String
    var imageURL: String
    
    init(p: Product?) {
        self.id = p?.id ?? Int.random(in: 300...10000)
        self.title = p?.title ?? ""
        self.description = p?.description ?? ""
        self.price = p?.price != nil ? String(p!.price) : ""
        self.brand = p?.brand ?? ""
        self.imageURL = p?.thumbnail ?? ""
    }
    
    func resetForm() {
        title = ""
        description = ""
        price = ""
        brand = ""
        imageURL = ""
    }
}
