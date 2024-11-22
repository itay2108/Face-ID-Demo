//
//  RecipeRepository.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

protocol RecipeServiceProtocol {
    func fetchRecipes() async -> Result<RecipeResponse, Error>
}

final class RecipeService: RecipeServiceProtocol {
    func fetchRecipes() async -> Result<RecipeResponse, Error> {
        await NetworkService.request(
            for: RecipeRequests.allRecipes,
            decodeWith: RecipeResponse.self
        )
    }
}
