//
//  ContentView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI



struct ContentView: View {
    @State var vm = AppViewModel()
    //TODO: make the code more efficient
    
    var body: some View {
        if vm.hasLoggedIn {
            MainView(vm: $vm)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .trailing))
                .environment(\.locale, Locale(identifier: vm.chosenLanguage.langIdentifier))
                .environment(\.layoutDirection, .leftToRight) // Force LTR layout direction
                .environment(\.colorScheme, vm.isDarkMode ? .dark : .light)
        } else {
            LoginView(vm: $vm)
                .transition(.move(edge: .leading))
                .background(.cyan.gradient)
                .environment(\.locale, Locale(identifier: vm.chosenLanguage.langIdentifier))
                .environment(\.layoutDirection, .leftToRight)
                .environment(\.colorScheme, vm.isDarkMode ? .dark : .light)
        }
        
    }
}

#Preview("english") {
    ContentView()
}

#Preview("hebrew") {
    ContentView()
        .environment(\.locale, Locale(identifier: "HE"))
}

