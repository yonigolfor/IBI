//
//  FavoritesView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 30/07/2024.
//

import SwiftUI
import RealmSwift

struct FavoritesView: View {
    @ObservedResults(FavoriteProduct.self) var allFavorites

    
    var body: some View {
        VStack{
            Text("Favorites")
                .font(.title).bold()
            if allFavorites.count > 0 {
                List{
                    ForEach(allFavorites) { favorite in
                        HStack{
                            Spacer()

                            VStack{
                                WebImageView(imageString: favorite.thumbnail, isLargeImage: false)
                                Text(favorite.title)
                                
                            }
                            Spacer()
                            Text(favorite.formattedPrice)
                            Spacer()

                            
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.pink)
                                .font(.title)
                        }
                    }
                    .onDelete(perform: $allFavorites.remove)

                }
            } else {
                Text("No Favorites Found")
            }
        }
    }
}

#Preview {
    FavoritesView()
}
