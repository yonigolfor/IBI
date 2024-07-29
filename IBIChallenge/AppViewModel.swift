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
    var chosenLanguage: LanguageOptionType = .en {
        didSet{
            setChosenLanguageUserDefaults(as: chosenLanguage)
        }
    }
    var isDarkMode: Bool = false
    
    init(){
        //retrieve if is in dark mode
        setIsDarkModeUserDefaults()
        getChosenLanguageUserDefaults()
    }
    
    func toggleDarkMode(){
        isDarkMode = isDarkMode ? false : true
        // update UserDefaults
        UserDefaults.standard.set(isDarkMode, forKey: "is-dark-mode")

    }
    
    func setIsDarkModeUserDefaults(){
        let isDarkModeStorage = UserDefaults.standard.bool(forKey: "is-dark-mode")
        if isDarkModeStorage {
            self.isDarkMode = isDarkModeStorage
            // default is false, prevent rerenders.
        }
    }
    
    func setChosenLanguageUserDefaults(as language: LanguageOptionType){
        UserDefaults.standard.set(self.chosenLanguage.langIdentifier, forKey: "selected-language")
    }
    
    func getChosenLanguageUserDefaults() {
        let selectedLanguageStorage = UserDefaults.standard.string(forKey: "selected-language")
        if let safeSelectedLanguageStorage = selectedLanguageStorage,
           safeSelectedLanguageStorage != self.chosenLanguage.langIdentifier{
            self.chosenLanguage = .he
        }
    }
    
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
