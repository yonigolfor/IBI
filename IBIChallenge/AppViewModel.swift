//
//  AppViewModel.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import Foundation
import SwiftUI

@Observable
class AppViewModel {
    var hasLoggedIn: Bool = false
    var chosenLanguage: LanguageOptionType = .en
    
    func loginUser(){
        withAnimation {
            self.hasLoggedIn = true
        }
    }
    
    func logoutUser(){
        withAnimation {
            self.hasLoggedIn = false
        }
    }
}
