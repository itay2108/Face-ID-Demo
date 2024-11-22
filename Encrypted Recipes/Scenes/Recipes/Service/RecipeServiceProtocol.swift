//
//  RecipeServiceProtocol.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 22/11/2024.
//

protocol RecipeServiceProtocol {
    func fetchRecipes() async -> Result<RecipeResponse, Error>
}
