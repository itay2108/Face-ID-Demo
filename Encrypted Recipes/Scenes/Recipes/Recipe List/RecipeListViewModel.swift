//
//  ArticlesViewModel.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import Foundation
import Combine

final class RecipeListViewModel {

    private let service: any RecipeServiceProtocol
    private let authenticationService = AuthenticationService()

    // MARK: - View Parameters

    @Published var selectedRecipe: RecipeModel?
    @Published var authenticationError: AuthenticationError?

    // MARK: - Loadable

    @Published var state: LoadingState<RecipeResponse> = .idle

    init(service: any RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }

    // MARK: - Combine

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Child ViewModels

    func listItemViewModel(for recipe: RecipeModel) -> ThumbnailListItemViewModel<RecipeModel> {
        let viewModel = ThumbnailListItemViewModel(model: recipe)

        viewModel.itemPressedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] recipe in
                self?.handleSelected(recipe)
            }
            .store(in: &cancellables)
        return viewModel
    }

    func recipeViewModel(for recipe: RecipeModel) -> RecipeViewModel {
        return .init(recipe: recipe)
    }

    func handleSelected(_ recipe: RecipeModel) {
        Task {
            let authenticationResult = await authenticationService.authenticateUser()

            runOnMainThread { [weak self] in
                switch authenticationResult {
                case .success:
                    self?.selectedRecipe = recipe
                case .failure(let error):
                    self?.authenticationError = error
                }
            }
        }
    }

    var authenticationErrorAlertButtonTitle: String? {
        switch authenticationError {
        case .userDenied, .userDidNotSetup:
            return "Open Settings"
        default:
            return nil
        }
    }

    func authenticationErrorAlertButtonAction() {
        URL.openSettings()
    }
}

extension RecipeListViewModel: Loadable {
    func loader() async -> Result<[RecipeModel], any Error> {
        return await service.fetchRecipes()
    }
}
