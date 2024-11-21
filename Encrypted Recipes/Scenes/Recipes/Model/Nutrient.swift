//
//  Nutrient.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 22/11/2024.
//

enum Nutrient: String {
    case calories
    case carbs
    case fat

    var label: String {
        self.rawValue.capitalized
    }

    func valueLabel(for recipe: RecipeModel) -> String {
        switch self {
        case .calories:
            return recipe.calories.ifNilOrEmpty(" - kcal")
        case .carbs:
            return recipe.carbs.ifNilOrEmpty(" - g")
        case .fat:
            return recipe.fats.ifNilOrEmpty(" - g")
        }
    }
}
