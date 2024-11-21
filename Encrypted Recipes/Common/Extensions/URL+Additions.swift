//
//  URL+Additions.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 22/11/2024.
//

import UIKit

extension URL {
    static func openSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
    }
}
