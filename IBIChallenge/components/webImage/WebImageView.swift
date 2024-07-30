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
    @State var isLoadingFailed: Bool = false
    
    private var imageSize: CGFloat {
        isLargeImage ? 100 : 50
    }
    
    var body: some View {
        if isLoadingFailed {
            Rectangle().fill(.pink.gradient)
                .overlay{
                    Text("Error")
                        .font(.caption)
                        .minimumScaleFactor(0.5)
                        .bold()
                        .rotationEffect(.degrees(-35))
                        .shadow(radius: 10)
                }
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 14))

        } else {
            WebImage(url: URL(string: imageString)) { image in
                image.resizable()
                
            } placeholder: {
                Rectangle().fill(.black.gradient)
                    .overlay{
                        ProgressView().tint(.blue)
                            .scaleEffect(CGSize(width: 2.5, height: 2.5))
                    }
            }
            .onFailure{_ in
                self.isLoadingFailed = true
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }
}

#Preview {
    let str2 = "https://via.placeholder.com/100abc"
    return WebImageView(imageString: str2, isLargeImage: false)
}
