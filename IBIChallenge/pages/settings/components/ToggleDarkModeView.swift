//
//  ToggleDarkModeView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 29/07/2024.
//

import SwiftUI

struct ToggleDarkModeView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text("toggle dark mode")
                .padding()
                .background(.orange.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 28))
            
        })
    }
}

#Preview {
    ToggleDarkModeView(action: {})
}
