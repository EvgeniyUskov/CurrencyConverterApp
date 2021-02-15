//
//  ConversionInteractorTest.swift
//  CurrencyConverterAppTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import XCTest
@testable import CurrencyConverterApp

class ConversionInteractorTest: XCTestCase {

    var interactor: ConversionInteractor?
    var viewModel: ConversionViewModel?
    var networkManager: NetworkManagerStub?
    var storageManager: StorageManagerStub?
    var viewController: ConversionViewControllerProtocol?
    var presenter: ConversionPresenterProtocol?
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerStub()
        storageManager = StorageManagerStub()
        viewModel = ConversionViewModel()
        guard let vm = viewModel else { throw TestErrors.someError("no ViewModel")}
        viewController = ConversionVCStub(viewModel: vm)
        guard let vc = viewController else {throw TestErrors.someError("no ConversionViewController")}
        guard let networkMngr = networkManager else {throw TestErrors.someError("no NetworkManager")}
        presenter = ConversionPresenterStub(viewController: vc)
        interactor = ConversionInteractor(presenter: presenter, networkManager: networkMngr)
        
    }

    override func tearDownWithError() throws {
        interactor = nil
        viewModel = nil
    }

    func testInteractorUpdateRatesSuccess() throws {
        interactor?.updateRates(for: viewModel?.rateViewModel, completionHandler: {
                [weak self] in
            XCTAssertEqual(self?.viewModel?.rateViewModel?.conversionRate, 10, "wrong rate number")
            XCTAssertEqual(self?.viewModel?.rateViewModel?.currencyConversionId, "foo1_foo2", "wrong conversion id")
            })
    }
    
    func testInteractorFetchRatesSuccess() throws {
        guard let context = storageManager?.context else {throw TestErrors.noContext("no context") }
        let entity1 = CurrencyCachedEntity(context: context)
        entity1.id = "foo1"
        entity1.currencyName = "fooName1"
        let cur1Opt = Currency(from: entity1)
        guard let cur1 = cur1Opt else {throw TestErrors.someError("no cur1") }
        let cur1VM = ConversionCurrencyViewModel(currency: cur1)
        
        let entity2 = CurrencyCachedEntity(context: context)
        entity2.id = "foo2"
        entity2.currencyName = "fooName2"
        let cur2Opt = Currency(from: entity2)
        guard let cur2 = cur2Opt else {throw TestErrors.someError("no cur2") }
        let cur2VM = ConversionCurrencyViewModel(currency: cur2)
        
        let rate = CurrencyRate(currencyConversionId: "foo1_foo2", conversionRate: 10)
        let rateVM = RateViewModel()
        rateVM.setRate(currencyRate: rate)
        rateVM.fromCurrency = cur1VM
        rateVM.toCurrency = cur2VM
        let directiveOpt = ConversionDirective(from: rateVM)
        guard let directive = directiveOpt else {throw TestErrors.someError("no directive") }
        
        interactor?.fetchRates(conversionDirective: directive, completionHandler: {
            rateInner in
            XCTAssertEqual(rateInner.conversionRate, rate.conversionRate, "wrong rate")
            XCTAssertEqual(rateInner.currencyConversionId, rate.currencyConversionId, "wrong conversionId")
        })
    }
    
    func testInteractorCalculateAmountSucces() throws {
        let value : Float = 100
        let rate : Float = 10
        guard let interactor = interactor else {throw TestErrors.someError("no Interactor")}
        
        let resultForward = interactor.calculateAmount(for: value, rate: rate, direction: .upToDown)
        let resultBackward = interactor.calculateAmount(for: value, rate: rate, direction: .downToUp)
        
        XCTAssertEqual(resultForward, Optional(value * rate), "wrong conversion forward result")
        XCTAssertEqual(resultBackward, Optional(value / rate), "wrong conversion backward result")
    }

}
