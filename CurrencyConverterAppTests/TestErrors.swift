//
//  TestErrors.swift
//  CurrencyConverterAppTests
//
//  Created by Evgeniy Uskov on 16/02/2021.
//

import Foundation
@testable import CurrencyConverterApp

enum TestErrors: Error {
    case noContext(_ text: String?)
    case someError(_ text: String?)
    case unknown
}
