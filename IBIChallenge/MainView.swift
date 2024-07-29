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
                    getPageView(for: page)
                        .tabItem {
                            Label(page.rawValue, systemImage: getSystemImage(for: page))
                        }
                        .tag(page)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        

    }
}

@ViewBuilder
private func getPageView(for page: PageType) -> some View {
    switch page {
    case .products:
        ProductsListView()
    case .settings:
        Circle()
            .fill(.purple)
    case .favorites:
        Circle()
            .fill(.cyan)
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
