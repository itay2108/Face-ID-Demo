//
//  NetworkService.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    associatedtype T: Codable
    
    static func request(for requestable: Requestable) async -> Result<T, Error>
    static func request(for requestable: Requestable, decodeWith responseType: T.Type) async -> Result<T, Error>
}

enum NetworkService<ResponseType: Codable>: NetworkServiceProtocol {

    static func request(for requestable: Requestable) async -> Result<ResponseType, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: try requestable.asURLRequest())
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }

    static func request(for requestable: Requestable, decodeWith responseType: ResponseType.Type) async -> Result<T, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: try requestable.asURLRequest())
            let decodedData = try JSONDecoder().decode(responseType, from: data)

            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }

}
