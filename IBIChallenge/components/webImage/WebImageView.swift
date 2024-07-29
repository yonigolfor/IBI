//
//  WebImageView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 29/07/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    let imageString: String
    var isLargeImage: Bool = true
    
    var body: some View {
        WebImage(url: URL(string: imageString)) { image in
            image.resizable()
            
        } placeholder: {
            Rectangle().fill(.black.gradient)
                .overlay{
                    ProgressView().tint(.blue)
                        .scaleEffect(CGSize(width: 2.5, height: 2.5))
                }
            }
//            .onSuccess { image, data, cacheType in
//            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: isLargeImage ? 100 : 50, height: isLargeImage ? 100 : 50)
            .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    let str2 = "https://via.placeholder.com/100"
    return WebImageView(imageString: str2)
}
