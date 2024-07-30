//
//  AppViewModel.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import Foundation
import SwiftUI
import RealmSwift

@Observable
class AppViewModel {
    var hasLoggedIn: Bool = false
    var chosenLanguage: LanguageOptionType = .en {
        didSet{
            setChosenLanguageUserDefaults(as: chosenLanguage)
        }
    }
    var isDarkMode: Bool = false
    
    var favoriteProducts: Results<FavoriteProduct>? {
            didSet {
                print("favorites in controller been set!")
            }
        }
    
    init(){
        // Retrieve UserDefaults data
        setIsDarkModeUserDefaults()
        getChosenLanguageUserDefaults()
        
        // Retrieve Realm data - Favorites
        getRealmFavorites()
        
        print("realm path = \(Realm.Configuration.defaultConfiguration.fileURL?.path)")
        
    }
    
    private func getRealmFavorites(){
        let favorites = RealmManager.shared.getFavoriteProducts()
        print("favorites = \(favorites)")
        self.favoriteProducts = favorites
    }
    
    private func addRealmFavorites(_ product: FavoriteProduct){
        print("reach 2")
        RealmManager.shared.addFavoriteProduct(product)
    }
    
    private func removeRealmFavorite(product: FavoriteProduct){
        RealmManager.shared.removeFavoriteProduct(product)
    }
    
    func toggleRealmFavorite(shouldAdd: Bool, product: FavoriteProduct) {
        print("toggle shouldAdd = \(shouldAdd)")
        shouldAdd ? addRealmFavorites(product) : removeRealmFavorite(product: product)
    }
    
    func productIsFavorite(_ productID: Int) -> Bool {
        if let safeFavoriteProducts = self.favoriteProducts {
            return safeFavoriteProducts.contains { $0.id == productID }
        }
        return false
    }
    
    func toggleDarkMode(){
        isDarkMode = isDarkMode ? false : true
        // update UserDefaults
        UserDefaults.standard.set(isDarkMode, forKey: K.UserDefaultsStorage.darkModeKey)

    }
    
    func setIsDarkModeUserDefaults(){
        let isDarkModeStorage = UserDefaults.standard.bool(forKey: K.UserDefaultsStorage.darkModeKey)
        if isDarkModeStorage {
            self.isDarkMode = isDarkModeStorage
            // default is false, prevent rerenders.
        }
    }
    
    func setChosenLanguageUserDefaults(as language: LanguageOptionType){
        UserDefaults.standard.set(self.chosenLanguage.langIdentifier, forKey: K.UserDefaultsStorage.selectedLanguageKey)
    }
    
    func getChosenLanguageUserDefaults() {
        let selectedLanguageStorage = UserDefaults.standard.string(forKey: K.UserDefaultsStorage.selectedLanguageKey)
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
