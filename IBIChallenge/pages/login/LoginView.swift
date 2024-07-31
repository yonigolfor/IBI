//
//  LoginView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI

struct LoginView: View {
    @Binding var vm: AppViewModel
    
    @State private var username = "testuser" //TODO: empty
    @State private var password = "12345678" //TODO: empty
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private let successUser = "testuser"
    private let successPassword = "12345678"

    var body: some View {
        VStack {
            LottieView(filename: "balbazor.json")
                .frame(height: 220)
            
            Text("Login")
                .font(.title)
            
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
           
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Login") {
                // Simulate login validation
                if username.lowercased() == successUser.lowercased() && password == successPassword {
                    vm.loginUser()
                } else {
                    showAlert = true
                    alertMessage = "Invalid username or password."
                    resetInputs()
                }
            }
            .padding()
            
            BiometricAuthView(hasLoggedIn: $vm.hasLoggedIn)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("User not found"),
                message: Text("Username or password are wrong."),
                dismissButton: .default(Text("OK"))
            )
        }

    }
    
    private func resetInputs() {
        username = ""
        password = ""
    }
}

#Preview {
    LoginView(vm: .constant(AppViewModel()))
}
