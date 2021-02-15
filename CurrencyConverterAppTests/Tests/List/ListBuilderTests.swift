//
//  ListBuilderTests.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import XCTest
@testable import CurrencyConverterApp

class ListBuilderTests: XCTestCase {

    var builder: ListBuilder?
    
    override func setUpWithError() throws {
        builder = ListBuilder()
    }

    override func tearDownWithError() throws {
        builder = nil
    }

    func testBuilderSucces() throws {
        let vc = builder?.build()
        
        XCTAssertNotNil(vc?.presenter, "presenter must not be nil")
        XCTAssertNotNil(vc?.interactor, "interactor must not be nil")
        XCTAssertNotNil(vc?.router, "router must not be nil")
        XCTAssertNotNil(vc?.viewModel, "viewModel must not be nil")
    }
    
}
