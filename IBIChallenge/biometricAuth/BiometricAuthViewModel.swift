//
//  AuthenticationViewModel.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI
import LocalAuthentication


@Observable
class AuthenticationViewModel {
    var isAuthenticated = false
    var authError: Error?

    func authenticate(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        // Check if the device supports biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in to your account"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        completion(true)
                    } else {
                        self.authError = authenticationError
                        completion(false)
                    }
                }
            }
        } else {
            // No biometrics
            DispatchQueue.main.async {
                self.authError = error
                completion(false)
            }
        }
    }
}
