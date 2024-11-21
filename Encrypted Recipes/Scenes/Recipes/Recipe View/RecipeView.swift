//
//  RecipeView.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 22/11/2024.
//

import SwiftUI

struct RecipeView: View {

    private var viewModel: RecipeViewModel

    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            image
            textContent
        }
        .ignoresSafeArea(edges: .top)
    }

    @ViewBuilder
    private var image: some View {
        if let imageUrl = viewModel.imageUrl {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizedToFill()
                    .overlay {
                        Color.black.opacity(0.4)
                    }
            } placeholder: {
                Rectangle()
                    .fill(.gray)
            }
            .frame(height: 256)
        }
    }

    private var textContent: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.headline)

            nutrients

            Text(viewModel.description)
                .foregroundStyle(.text)

        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(.background)
    }

    private var nutrients: some View {
        HStack {
            ForEach(viewModel.nutrientLabels, id: \.nutrient) { label in
                nutrientLabel(
                    nutrient: label.nutrient,
                    value: label.value
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding([.vertical, .bottom], 16)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.gray.opacity(0.3))
        )
    }

    private func nutrientLabel(nutrient: String, value: String) -> some View {
        VStack {
            Text(nutrient)
                .font(.system(size: 16, weight: .bold))

            Text(value)
                .font(.system(size: 16, weight: .medium))
        }
    }
}

#Preview {
    RecipeView(
        viewModel: .init(
            recipe: .previewObject
        )
    )
}
