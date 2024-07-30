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
           .applyCommonEnvironmentModifiers(chosenLanguage: vm.chosenLanguage, isDarkMode: vm.isDarkMode)
           
       }
}

extension View {
    func applyCommonEnvironmentModifiers(chosenLanguage: LanguageOptionType, isDarkMode: Bool) -> some View {
        self
            .environment(\.locale, Locale(identifier: chosenLanguage.langIdentifier))
            .environment(\.layoutDirection, .leftToRight)
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

#Preview("english") {
    ContentView()
}

#Preview("hebrew") {
    ContentView()
        .environment(\.locale, Locale(identifier: "HE"))
}

