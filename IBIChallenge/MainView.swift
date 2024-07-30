//
//  TabView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI

struct MainView: View {
    @Binding var vm: AppViewModel
    @State private var selectedPage: PageType = .products
    
    var body: some View {
        VStack{
            TabView(selection: $selectedPage) {
                ForEach(PageType.allCases) { page in
                    getPageView(for: page, vm: $vm)
                        .tabItem {
                            Label(
                                title: { Text(page.localizedString)
                                },
                                icon: { Image(systemName: getSystemImage(for: page))
                                }
                            )
                        }
                        .tag(page)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onDisappear{
            print("Logged out successfully")
        }
      
    }
}

@ViewBuilder
private func getPageView(for page: PageType, vm: Binding<AppViewModel>) -> some View {
    switch page {
    case .products:
        ProductsListView(appVM: vm)
    case .settings:
        SettingsView(appVM: vm)
    case .favorites:
        FavoritesView()
    }
}
private func getSystemImage(for page: PageType) -> String {
    switch page {
    case .products:
        return "list.dash"
    case .settings:
        return "gear"
    case .favorites:
        return "star.fill"
    }
}

#Preview {
    MainView(vm: .constant(AppViewModel()))
}
