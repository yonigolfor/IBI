//
//  ContentView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI



struct ContentView: View {
    @State var vm = AppViewModel()
    
    var body: some View {
           Group {
               if vm.hasLoggedIn {
                   MainView(vm: $vm)
                       .transition(.move(edge: .trailing))
               } else {
                   LoginView(vm: $vm)
                       .transition(.move(edge: .leading))
                       .background(.cyan.gradient)
               }
           }
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .applyCommonEnvironmentModifiers(vm: vm)
       }
}

extension View {
    func applyCommonEnvironmentModifiers(vm: AppViewModel) -> some View {
        self
            .environment(\.locale, Locale(identifier: vm.chosenLanguage.langIdentifier))
            .environment(\.layoutDirection, .leftToRight)
            .environment(\.colorScheme, vm.isDarkMode ? .dark : .light)
    }
}

#Preview("english") {
    ContentView()
}

#Preview("hebrew") {
    ContentView()
        .environment(\.locale, Locale(identifier: "HE"))
}

