//
//  SettingsView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 29/07/2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var appVM: AppViewModel

    var body: some View {
            VStack{
                Text("Settings")
                    .font(.title)
                    .bold()
                Spacer()

                PickLanguageView(chosenLanguage: $appVM.chosenLanguage)
                
                ToggleDarkModeButton(action: appVM.toggleDarkMode)
                .padding(.top, 20)
                
                Spacer()
                
                Button(action: {appVM.logoutUser()}, label: {
                    Text("Log Out")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 28.0))
                        .opacity(0.9)
                })
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan.gradient)
    }
}

#Preview {
    SettingsView(appVM: .constant(AppViewModel()))
}
