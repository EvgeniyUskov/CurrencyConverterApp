//
//  ConversionInteractorStub.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import Foundation
@testable import CurrencyConverterApp

//MARK: ConversionInteractorStub
public class ConversionInteractorStub {
    //MARK: Properties
    weak var presenter: ConversionPresenterProtocol?
    var networkManager: NetworkManagerProtocol?
    
    //MARK: Init
    public init(presenter: ConversionPresenter?, networkManager: NetworkManagerProtocol) {
        self.presenter = presenter
        self.networkManager = networkManager
    }
}

//MARK: ConversionInteractorProtocol implementation
extension ConversionInteractorStub: ConversionInteractorProtocol {
    public func calculateAmount(for value: Float, rate: Float, direction: ConversionDirection) -> Float? {
        switch direction {
        case .upToDown:
            return 10
        case .downToUp:
            return 100
        }
    }
    
    public func updateRates(for viewModel: RateViewModel?, completionHandler: @escaping () -> ()) {
        let rate = CurrencyRate(currencyConversionId: "foo1_foo2", conversionRate: 10)
        viewModel?.setRate(currencyRate: rate)
        completionHandler()
    }
    
    public func setFromCurrency(currency: Currency) {
        presenter?.presentFromCurrency(currency: currency)
    }
    
    public func setToCurrency(currency: Currency) {
        presenter?.presentToCurrency(currency: currency)
    }
}

