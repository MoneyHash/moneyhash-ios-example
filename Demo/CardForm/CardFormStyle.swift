//
//  CardFormStyle.swift
//  Demo
//
//  Created by Kerollos Nabil on 10/11/2024.
//

import SwiftUI

struct CardFormStyle: ViewModifier {
    var isOnFocused: Bool
    var errorMessage: String?
    var imageURL:URL? = nil

    func body(content: Content) -> some View {
        
        HStack {
            VStack {
                content
                .padding()
                if let error = errorMessage, !isOnFocused {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                        .background(Rectangle().fill(.red.opacity(0.3)))

                }
                
            }
            if let url =  imageURL {
                SVGImageView(url: url).frame(width: 50, height: 50)
            }
        }
        
        .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(errorMessage != nil && !isOnFocused ? Color.red : Color.gray, lineWidth: 1)
                    .shadow(color: errorMessage != nil && !isOnFocused ? Color.red : Color.gray, radius: 2, x: 0, y: 2)
            )
    }
}

extension View {
    func cardFormStyle(isOnFocused: Bool, errorMessage: String?, imageURL:URL? = nil) -> some View {
        self.modifier(CardFormStyle(isOnFocused: isOnFocused, errorMessage: errorMessage, imageURL: imageURL))
    }
}
