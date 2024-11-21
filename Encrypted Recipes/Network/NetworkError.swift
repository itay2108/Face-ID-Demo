//
//  NetworkError.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case generic
    case badRequest
    case forbidden
    case notFound
    case serverError
    case timeout
    case noInternetConnection
    case requestCancelled
    case decodingFailed
    case invalidResponse
    case urlInvalid
    case dataMissing
    case unknownError

    var errorDescription: String? {
        switch self {
        case .generic:
            return "Something went wrong. Please try again."
        case .badRequest:
            return "Invalid request. Please check your input."
        case .forbidden:
            return "You don’t have permission to do that."
        case .notFound:
            return "We couldn’t find what you’re looking for."
        case .serverError:
            return "Server error. Please try again later."
        case .timeout:
            return "The request is taking too long. Please try again."
        case .noInternetConnection:
            return "No internet connection. Check your network settings."
        case .requestCancelled:
            return "The request was cancelled. Please try again."
        case .decodingFailed:
            return "We couldn’t process the server response."
        case .invalidResponse:
            return "The server returned an unexpected response."
        case .urlInvalid:
            return "The link seems to be invalid."
        case .dataMissing:
            return "No data available. Please try again."
        case .unknownError:
            return "An unexpected error occurred. Please try again."
        }
    }
}
