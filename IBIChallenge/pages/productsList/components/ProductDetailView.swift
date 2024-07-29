//
//  ProductDetailView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        VStack(spacing: 15) {
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
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.cyan)
    }
}


#Preview {
    ProductDetailView(product: Product(id: 0, title: "aa", description: "1111", price: 12, brand: "GOLFOR", thumbnail: "123", images: nil))
}
