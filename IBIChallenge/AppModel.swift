//
//  AppModel.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import Foundation

enum PageType: String, CaseIterable, Identifiable {
    case products = "Products"
    case settings = "Settings"
    case favorites = "Favorites"
    
    var id: String { self.rawValue }
}
