//
//  RecipeItemView.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import SwiftUI

struct ThumbnailListItem<T: ThumbnailListItemPresentable>: View {

    // MARK: - View Parameters

    private var viewModel: ThumbnailListItemViewModel<T>

    //MARK: - Init

    init(viewModel: ThumbnailListItemViewModel<T>) {
        self.viewModel = viewModel
    }

    // MARK: - Main Content

    var body: some View {
        mainContent
            .contentShape(Rectangle())
            .frame(height: 72)
            .onTapGesture {
                viewModel.itemTapped()
            }
    }

    private var mainContent: some View {
        HStack {
            HStack(alignment: .top, spacing: 14) {
                thumbnail
                labels
            }
            Spacer()
            disclosureIndicator
        }
    }

    // MARK: - Subviews

    @ViewBuilder
    private var thumbnail: some View {
        if let thumbnailUrl = viewModel.thumbnailUrl {
            AsyncImage(url: thumbnailUrl) { image in
                image
                    .resizedToFill()
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 84, height: 72)
            }
            .frame(width: 84)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

    private var labels: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.headline)
                .foregroundStyle(.headline)

            if let subtitle = viewModel.subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.text)
            }
        }
        .foregroundStyle(.gray)
    }

    private var disclosureIndicator: some View {
        Image(systemName: "chevron.right")
            .resizedToFit(height: 12)
            .foregroundStyle(.tint)
            .padding(.horizontal, 12)
    }
}

#Preview {
    ThumbnailListItem(
        viewModel: .init(
            model: RecipeModel.previewObject
        )
    )
}
