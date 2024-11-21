//
//  RecipeListView.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import SwiftUI

struct RecipeListView: View {

    // MARK: Parameters

    private typealias VM = RecipeListViewModel
    @ObservedObject private var viewModel: VM

    // MARK: - Init

    init(viewModel: RecipeListViewModel = .init()) {
        self.viewModel = viewModel
    }

    // MARK: - Main Body

    var body: some View {
        NavigationStack {
            LoadableView(viewModel: viewModel) {
                ProgressView()
            } content: { recipes in
                recipeList(recipes)
            }
            .navigationTitle("Recipes")
            .navigationDestination(item: $viewModel.selectedRecipe) { recipe in
                RecipeView(viewModel: viewModel.recipeViewModel(for: recipe))
            }
            .alert(item: $viewModel.authenticationError) { error in
                errorAlert(error: error)
            }
        }
    }

    // MARK: - Recipe List

    private func recipeList(_ recipes: VM.LoadableDataType) -> some View {
        List(recipes) { recipe in
            recipeView(recipe, showsSeparator: recipes.last?.id != recipe.id)
        }
        .listStyle(.plain)
    }

    private func recipeView(
        _ recipe: VM.LoadableDataType.Element,
        showsSeparator: Bool
    ) -> some View {
        VStack {
            ThumbnailListItem(
                viewModel: viewModel.listItemViewModel(
                    for: recipe
                )
            )
        }
    }

    private func errorAlert(error: Error) -> Alert {
        if let primaryButtonTitle = viewModel.authenticationErrorAlertButtonTitle {
            Alert(
                title: Text("Authentication Denied"),
                message: Text(error.localizedDescription),
                primaryButton: .default(Text(primaryButtonTitle), action: viewModel.authenticationErrorAlertButtonAction),
                secondaryButton: .cancel()
            )
        } else {
            Alert(
                title: Text("Something when wrong"),
                message: Text(error.localizedDescription),
                dismissButton: .cancel()
            )
        }

    }
}

#Preview {
    RecipeListView()
}
