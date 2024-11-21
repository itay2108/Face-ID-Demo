//
//  RecipeModel.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import Foundation

typealias RecipeResponse = [RecipeModel]

struct RecipeModel: Codable, Hashable, Identifiable {
    let difficulty: Int
    let id, name, description: String
    let calories, carbs, fats, headline, image, proteins, thumb: String?
    let time: String?

    private enum CodingKeys: String, CodingKey {
        case calories
        case carbs = "carbos"
        case description
        case difficulty
        case fats
        case headline
        case id
        case image
        case name
        case proteins
        case thumb
        case time
    }
}
