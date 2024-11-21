//
//  RunOnMainThread.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import Foundation

public func runOnMainThread(_ block: @escaping () -> Void) {
    if Thread.isMainThread || isUnitTest {
        block()
    } else {
        DispatchQueue.main.async {
            block()
        }
    }
}

var isUnitTest: Bool {
    return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}
