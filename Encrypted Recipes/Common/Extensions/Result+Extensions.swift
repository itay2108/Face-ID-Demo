//
//  Result+Extensions.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import Foundation

extension Result {
    /// Returns the success object on success, otherwise nil.
    /// This is a way to erase the result enum to a singular result type for cases where there is no need to react to failures
    /// - Returns: an optional success object
    func eraseToValue() -> Success? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    /// Performs the passed async function on the success object before returning the result
    /// - Parameter onSuccess: the  async function to perform on the object in case of a success
    /// - Returns: the original result unmodified
    @discardableResult
    func whenSuccessful(_ performOnSuccess: (Success) async -> Void) async -> Result<Success, Failure> {
        switch self {
        case .success(let success):
            await performOnSuccess(success)
        case .failure:
            break
        }

        return self
    }

    /// Performs the passed function on the failure object before returning the result
    /// - Parameter onFailure: the function to perform on the object in case of a failure
    /// - Returns: the original result unmodified
    @discardableResult
    func whenFailed(_ performOnFailure: (Failure) async -> Void) async -> Result<Success, Failure> {
        switch self {
        case .success:
            break
        case .failure(let error):
            await performOnFailure(error)
        }

        return self
    }

    /// Transforms the success object of the result asynchronously
    /// - Parameter transform: the asynchronous method to perform on the object in a case of success
    /// - Returns: a Result where the Success object is the transformed one
    func mapSuccess<T>(_ transform: (Success) async -> T) async -> Result<T, Error> {
        switch self {
        case .success(let value):
            return .success(await transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }

    func transform<T>(_ transformationMethod: (Success) async throws -> Result<T, Error>) async -> Result<T, Error> {
        switch self {
        case .success(let value):
            do {
                return try await transformationMethod(value)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    func throwErrors() throws -> Success {
        switch self {
        case .success(let success):
            return success
        case .failure(let failure):
            throw failure
        }
    }
}
