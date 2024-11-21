//
//  AuthenticationError.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 22/11/2024.
//

import Foundation
import LocalAuthentication

enum AuthenticationError: LocalizedError, Identifiable {

    case biometricsUnavailable
    case authenticationFailed
    case userDenied
    case userDidNotSetup
    case unknownError(String)

    var id: Int {
        switch self {
        case .authenticationFailed:
            return 0
        case .biometricsUnavailable:
            return 1
        case .userDenied:
            return 2
        case .userDidNotSetup:
            return 3
        case .unknownError:
            return -1
        }
    }

    var errorDescription: String? {
        switch self {
        case .biometricsUnavailable:
            return "Biometric authentication is unavailable on this device."
        case .authenticationFailed:
            return "Authentication failed. Please try again."
        case .userDenied:
            return "Open settings to allow Face ID"
        case .userDidNotSetup:
            return "Set up Face ID in settings"
        case .unknownError(let message):
            return message
        }
    }

    init(_ error: any Error) {
        if let error = error as? LAError {
            switch error.code {
            case .biometryNotAvailable:
                self = .userDenied
            case .biometryNotEnrolled:
                self = .userDidNotSetup
            default:
                self = .biometricsUnavailable
            }
        } else {
            self = .unknownError(error.localizedDescription)
        }
    }
}
