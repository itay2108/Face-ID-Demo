//
//  RecipeModel+ThumbAndTitle.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

extension RecipeModel: ThumbnailListItemPresentable {

    var title: String {
        name
    }

    var subtitle: String? {
        return [Nutrient.calories, Nutrient.carbs, Nutrient.fat]
            .map({ $0.valueLabel(for: self) })
            .joined(separator: " | ")
    }

    var thumbnailStringUrl: String? {
        image
    }
}
