//
//  AppModel.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import Foundation
import SwiftUI

enum PageType: CaseIterable, Identifiable {
    case products
    case settings
    case favorites
    
    var id: Self { self }
    
    var localizedString: LocalizedStringResource {
        switch self {
        case .products:
            "Products"
        case .settings:
            "Settings"
        case .favorites:
            "Favorites"
        }
    }
}

enum LanguageOptionType: String, CaseIterable, Identifiable{
    case en = "English"
    case he = "Hebrew"
    
    var id: Self { self }
    
    var langIdentifier: String {
        switch self {
        case .en:
            "en"
        case .he:
            "he"
        }
    }
}
                
