//
//  RecipeViewModel.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 22/11/2024.
//

import Foundation

final class RecipeViewModel {

    private let recipe: RecipeModel
    private let displayedNutrients: [Nutrient] = [.calories, .carbs, .fat]

    init(recipe: RecipeModel) {
        self.recipe = recipe
    }

    var title: String {
        var needsSpacingInSeparator: Bool {
            recipe.name.last?.isWhitespace == true || recipe.headline?.first?.isWhitespace == true
        }

        let separator = needsSpacingInSeparator ? " " : ""
        return [recipe.name, recipe.headline].compactMap({ $0 }).joined(separator: separator)
    }

    var description: String {
        recipe.description
    }

    var imageUrl: URL? {
        guard let stringUrl = recipe.image else { return nil }
        return URL(string: stringUrl)
    }

    // MARK: - Nutrients

    var nutrientLabels: [(nutrient: String, value: String)] {
        return displayedNutrients.map { nutrient in
            (nutrient: nutrient.label, value: nutrient.valueLabel(for: recipe))
        }
    }
}
