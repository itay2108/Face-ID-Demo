//
//  AuthenticationService.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 22/11/2024.
//

import Foundation
import LocalAuthentication

final class AuthenticationService {
    private let context = LAContext()

    private var isAuthenticated: Bool = false

    func authenticateUser(forceNewAuthentication: Bool = false) async -> Result<Bool, AuthenticationError> {
        var error: NSError?

        if forceNewAuthentication,
           isAuthenticated {
            return .success(true)
        }

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            if let error {
                return .failure(.init(error))
            } else {
                return .failure(.biometricsUnavailable)
            }
        }

        let reason = "We need to verify your identity using Face ID."

        do {
            let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
            self.isAuthenticated = success
            return .success(success)
        } catch {
            debugPrint("Authentication failed: \(error.localizedDescription)")
            return .failure(.init(error))
        }
    }

    func resetAuthentication() {
        self.isAuthenticated = false
    }
}
