//
//  ProductView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 28/07/2024.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
        VStack {
            HStack {
                WebImageView(imageString: product.thumbnail, isLargeImage: false)
                Spacer()
                Text(product.title)
                    .font(.body)
            }
                Spacer()
                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(product.formattedPrice)")
                    .font(.body)
            
        }
        .padding(15)
        .background(.cyan.gradient)
    }
}

#Preview {
    ProductRowView(product: Product(id: 0, title: "ab", description: "cde", price: 10, brand: nil, thumbnail: "https://via.placeholder.com/100", images: nil))
        .frame(height: 200)
}
