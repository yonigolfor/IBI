//
//  AuthenticationView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI

struct BiometricAuthView: View {
    @State private var viewModel = AuthenticationViewModel()
    @Binding var hasLoggedIn: Bool

    var body: some View {
        Button(action: {
            viewModel.authenticate{ hasSucceed in
                if hasSucceed {
                    withAnimation {
                        hasLoggedIn = true
                    }
                }
            }
        }) {
            HStack{
                Image(systemName: "faceid")
                    .font(.title)
                
                Text("Login with Touch ID/Face ID")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.authError != nil },
            set: { _ in viewModel.authError = nil }
        )) {
            Alert(title: Text("Authentication Error"), message: Text(viewModel.authError?.localizedDescription ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    BiometricAuthView(hasLoggedIn: .constant(false))
}
