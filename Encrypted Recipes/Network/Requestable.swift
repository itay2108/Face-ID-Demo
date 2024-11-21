//
//  Requestable.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import Foundation

protocol Requestable {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension Requestable {
    var baseUrl: String {
        "https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test"
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var body: [String: Any]? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseUrl)?.appendingPathComponent(path) else { throw NetworkError.urlInvalid }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let headers {
            headers.forEach { (key, value) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body{
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        return urlRequest
    }
}
