//
//  LoadableViewErrorConfiguration.swift
//  ios-sources-assignment
//
//  Created by Itay Gervash on 02/11/2023.
//

import Foundation

public enum LoadableViewErrorConfiguration: Equatable {
    /// Hides the error message, content height is 0
    case hidden

    /// Presents the error, content is full height
    case fullHeight

    /// The default implementation, content height is the pixel size of the error text
    case `default`

    /// Hides the error message but takes the entire screen height
    case empty

    var isErrorHidden: Bool {
        switch self {
        case .hidden, .empty:
            return true
        case .fullHeight, .`default`:
            return false
        }
    }

    var isErrorFullHeight: Bool {
        switch self {
        case .fullHeight, .empty:
            return true
        case .hidden, .`default`:
            return false
        }
    }
}
