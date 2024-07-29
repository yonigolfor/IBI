//
//  PickLanguageView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 29/07/2024.
//

import SwiftUI

struct PickLanguageView: View {
    @Binding var chosenLanguage: LanguageOptionType
    
    var body: some View {
        VStack{
            Text("Pick Language")
                .font(.title)
            Picker("Picker Name",
                   selection: $chosenLanguage) {
                ForEach(LanguageOptionType.allCases,
                        id: \.self) {
                    Text($0.rawValue)
                }
            }.pickerStyle(.segmented)
        }
    }
}

#Preview {
    PickLanguageView(chosenLanguage: .constant(.en))
}
