//
//  ToggleDarkModeView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 29/07/2024.
//

import SwiftUI

struct ToggleDarkModeButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text("Toggle Dark Mode")
                .padding()
                .background(.orange.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 28))
            
        })
    }
}

#Preview {
    ToggleDarkModeButton(action: {})
}
