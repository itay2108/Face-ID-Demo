//
//  Image+Resize.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import SwiftUI

extension Image {
    
    func resizedToFit(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height, alignment: alignment)
    }

    func resizedToFill(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height, alignment: alignment)
    }
}
