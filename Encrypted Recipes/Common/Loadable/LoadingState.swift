//
//  Loadable.swift
//  Car Data
//
//  Created by Itay Gervash on 27/12/2022.
//

import Foundation

///Describes the current loading state of a loadable object
public enum LoadingState<T>: Equatable {
    public static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        return lhs.equatableValue == rhs.equatableValue
    }
    
    case idle
    case loading
    case failed(Error)
    case loaded(T)
    
    private var equatableValue: Int {
        switch self {
        case .idle:
            return 0
        case .loading:
            return 1
        case .failed(_):
            return 2
        case .loaded(_):
            return 3
        }
    }
}

public extension LoadingState {
    init?(_ value: T) {
        self = .loaded(value)
    }
}
