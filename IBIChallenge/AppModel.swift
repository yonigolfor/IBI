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

enum LanguageOptionType: CaseIterable, Identifiable{
    case en
    case he
    
    var id: Self { self }
    
    var localizedString: LocalizedStringResource {
        switch self {
        case .en:
            "English"
        case .he:
            "Hebrew"
        }
    }
    
    var langIdentifier: String {
        switch self {
        case .en:
            "en"
        case .he:
            "he"
        }
    }
}
                
