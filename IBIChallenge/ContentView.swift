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
        if vm.hasLoggedIn {
            MainView(vm: $vm)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .trailing))

        } else {
            LoginView(vm: $vm)
                .transition(.move(edge: .leading))
                .background(.cyan.gradient)
        }
       
    }
}

#Preview {
    ContentView()
}
