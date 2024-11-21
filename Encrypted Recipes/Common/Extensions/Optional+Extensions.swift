//
//  Optional+Extensions.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 22/11/2024.
//

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self == nil || self?.isEmpty == true
    }

    func ifNilOrEmpty(_ fallback: Wrapped) -> Wrapped {
        if self.isNilOrEmpty {
            return fallback
        } else {
            return self!
        }
    }
}
