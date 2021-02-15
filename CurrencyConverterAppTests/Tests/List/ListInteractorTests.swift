//
//  ListInteractorTest.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import XCTest
@testable import CurrencyConverterApp

class ListInteractorTest: XCTestCase {

    var networkManager: NetworkManagerProtocol?
    var storageManager: StorageManagerStub?
    var viewModel: CurrencyListViewModel?
    var viewController: CurrencyListVCStub?
    var presenter: ListPresenterProtocol?
    var interactor: ListInteractor?
    var router: ListRouterProtocol?
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerStub()
        storageManager = StorageManagerStub()
        viewModel = CurrencyListViewModel()
        guard let vm = viewModel else { throw TestErrors.someError("no ViewModel")}
        viewController = CurrencyListVCStub(viewModel: vm)
        guard let vc = viewController else {throw TestErrors.someError("no ConversionViewController")}
        presenter = ListPresenterStub(viewController: vc)
        guard let networkMngr = networkManager else {throw TestErrors.someError("no NetworkManager")}
        guard let storageMngr = storageManager else {throw TestErrors.someError("no StorageManager")}
        interactor = ListInteractor(presenter: presenter,
                                        networkManager: networkMngr,
                                        storageManager: storageMngr)
        router = ListRouterStub(viewController: vc)

    }

    override func tearDownWithError() throws {
    }

    func testInteractorShowCurrenciesSuccess() throws {
        interactor?.showCurrencies(with: nil)
        
        XCTAssertEqual(viewController?.viewModel?.currencyViewModels?.count, 5, "wrong number of currencies")
    }

}
