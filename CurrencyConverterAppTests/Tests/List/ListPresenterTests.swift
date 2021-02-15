//
//  ListPresenterTest.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import XCTest
@testable import CurrencyConverterApp

class ListPresenterTest: XCTestCase {
    var networkManager: NetworkManagerProtocol?
    var storageManager: StorageManagerStub?
    var viewModel: CurrencyListViewModel?
    var viewController: CurrencyListVCStub?
    var presenter: ListPresenterProtocol?
    var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerStub()
        storageManager = StorageManagerStub()
        viewModel = CurrencyListViewModel()
        guard let vm = viewModel else { throw TestErrors.someError("no ViewModel")}
        viewController = CurrencyListVCStub(viewModel: vm)
        guard let vc = viewController else {throw TestErrors.someError("no ConversionViewController")}
        presenter = ListPresenter(viewController: vc)
        guard let networkMngr = networkManager else {throw TestErrors.someError("no NetworkManager")}
        guard let storageMngr = storageManager else {throw TestErrors.someError("no StorageManager")}
        interactor = ListInteractorStub(presenter: presenter,
                                        networkManager: networkMngr,
                                        storageManager: storageMngr)
        router = ListRouterStub(viewController: vc)

    }

    override func tearDownWithError() throws {
    }

    func testPresenterPresentData() throws {
        var currencies = [Currency]()
        for index in 1...5 {
            let entity = CurrencyCachedEntity()
            entity.id = "foo\(index)"
            entity.currencyName = "fooName\(index)"
            entity.currencySymbol = "fooSymbol\(index)"
            let currency = Currency(from: entity)
            guard let fakeCurrency = currency else {return}
            currencies.append(fakeCurrency)
        }
        presenter?.presentData(currencies: currencies)
        
        XCTAssertEqual(viewController?.viewModel?.currencyViewModels?.count, 5, "wrong number of currencies")
    }

}
