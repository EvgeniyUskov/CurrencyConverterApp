//
//  ConversionPresenterTest.swift
//  CurrencyConverterAppTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import XCTest
import RxSwift
import RxCocoa
@testable import CurrencyConverterApp

class ConversionPresenterTest: XCTestCase {

    var networkManager: NetworkManagerProtocol?
    var storageManager: StorageManagerStub?
    var viewModel: ConversionViewModel?
    var viewController: ConversionVCStub?
    var presenter: ConversionPresenter?
    var interactor: ConversionInteractorProtocol?
                                              
    override func setUpWithError() throws {
        networkManager = NetworkManagerStub()
        storageManager = StorageManagerStub()
        viewModel = ConversionViewModel()
        guard let vm = viewModel else { throw TestErrors.someError("no ViewModel")}
        viewController = ConversionVCStub(viewModel: vm)
        guard let vc = viewController else {throw TestErrors.someError("no ConversionViewController")}
        guard let networkMngr = networkManager else {throw TestErrors.someError("no NetworkManager")}
        presenter = ConversionPresenter(viewController: vc)
        interactor = ConversionInteractorStub(presenter: presenter, networkManager: networkMngr)
        
    }

    override func tearDownWithError() throws {
    }

    func testPresenterPresentFromCurrency() throws {
        guard let context = storageManager?.context else {throw TestErrors.noContext("no context") }
        let entity1 = CurrencyCachedEntity(context: context)
        entity1.id = "foo1"
        entity1.currencyName = "fooName1"
        let cur1Opt = Currency(from: entity1)
        guard let cur1 = cur1Opt else {throw TestErrors.someError("no cur1") }
        
        presenter?.presentFromCurrency(currency: cur1)
        
        XCTAssertNotNil(viewController?.viewModel?.rateViewModel?.fromCurrency)
        
    }

    func testPresenterPresentToCurrency() throws {
        guard let context = storageManager?.context else {throw TestErrors.noContext("no context") }
        let entity2 = CurrencyCachedEntity(context: context)
        entity2.id = "foo2"
        entity2.currencyName = "fooName2"
        let cur2Opt = Currency(from: entity2)
        guard let cur2 = cur2Opt else {throw TestErrors.someError("no cur2") }
        
        presenter?.presentToCurrency(currency: cur2)
        
        XCTAssertNotNil(viewController?.viewModel?.rateViewModel?.toCurrency)
    }
}
