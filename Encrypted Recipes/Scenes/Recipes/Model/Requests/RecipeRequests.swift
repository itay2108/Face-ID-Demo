//
//  RecipeRequest.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

enum RecipeRequests: Requestable {

    case allRecipes
    // add more requests here

    var path: String {
        switch self {
        case .allRecipes:
            return "/recipes.json"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .allRecipes:
            return .get
        }
    }
}
