//
//  ProductDetailView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI
import RealmSwift

struct ProductDetailView: View {
    @ObservedResults(FavoriteProduct.self) var allFavorites
    let product: Product
    let onToggleFavorite: (_ shouldAdd: Bool) -> Void
    let onUpdateProduct: (_ product: Product) -> Void
    
    @State var localIsFavorite: Bool = false
    @State var showFormSheet: Bool = false

    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()

            WebImageView(imageString: product.thumbnail, isLargeImage: true)
            
            Text(product.title)
                .font(.largeTitle)
            Text(product.description)
                .font(.body)
            if let brand = product.brand {
                Text(brand)
                    .font(.headline)
            }
            Text(product.formattedPrice)
                .font(.title)
           
            
            if let images = product.images{
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(images, id: \.self) { imageUrl in
                            WebImageView(imageString: imageUrl, isLargeImage: true)
                            .padding(5)
                        }
                    }
                }
            }
            Spacer()
            Button(action: handleFavoriteBtn, label: {
                Image(systemName: localIsFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(localIsFavorite ? .pink : .black)
                    .font(.title)
                    .scaleEffect(localIsFavorite ? 1.6 : 1.1)
            })
            .padding(.bottom, 16)
           
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.cyan)
        .onAppear{
            localIsFavorite = allFavorites.contains { $0.id == product.id }
        }
        .sheet(isPresented: $showFormSheet, content: presentNewProductForm)
        .toolbar(content: {
            Button(action: {
                self.showFormSheet = true
            }, label: {
                Text("Edit")
            })
        })
    }
    
    func presentNewProductForm() -> some View {
        NewProductFormView(
            onFinish: { updatedProduct in
                showFormSheet = false
                onUpdateProduct(updatedProduct)
            },
            product: product
        )
    }
    
    private func handleFavoriteBtn(){
        self.localIsFavorite.toggle()
        onToggleFavorite(self.localIsFavorite)
    }
}


#Preview {
    ProductDetailView(product: Product(id: 0, title: "aa", description: "1111", price: 12, brand: "GOLFOR", thumbnail: "123", images: nil), onToggleFavorite: {shouldAdd in print(shouldAdd) }, onUpdateProduct: {product in })
}
