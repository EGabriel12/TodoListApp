//
//  XCTestCase+Extension.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 13/08/22.
//

import Foundation
import XCTest

enum XCTestCaseError: Error {
    case failedToCast
}

extension XCTestCase {
    func cast<T, K>(from: T, to: K.Type) throws -> K {
        if let value = from as? K {
            return value
        }
        throw XCTestCaseError.failedToCast
    }
}
