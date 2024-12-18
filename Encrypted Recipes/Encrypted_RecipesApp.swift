//
//  Encrypted_RecipesApp.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import SwiftUI

@main
struct Encrypted_RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView()
        }
    }
}

extension App {
    static func openSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
    }
}
