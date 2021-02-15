//
//  ConversionPresenterStub.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import Foundation
@testable import CurrencyConverterApp

public class ConversionPresenterStub {
    //MARK: Properties
    weak var viewController: ConversionViewControllerProtocol?
    
    //MARK: Init
    public init(viewController: ConversionViewControllerProtocol) {
        self.viewController = viewController
    }
    
}

//MARK: ConversionPresenterProtocol Implementation
extension ConversionPresenterStub: ConversionPresenterProtocol {
    public func presentFromCurrency(currency: Currency) {
        let currencyViewModel = ConversionCurrencyViewModel(currency: currency)
        viewController?.displayFromCurrencyData(currencyViewModel: currencyViewModel)
    }
    
    public func presentToCurrency(currency: Currency) {
        let currencyViewModel = ConversionCurrencyViewModel(currency: currency)
        viewController?.displayToCurrencyData(currencyViewModel: currencyViewModel)
    }
    
    public func presentData(with currencyRate: CurrencyRate) {
        let viewModel = RateViewModel()
        viewController?.displayData(viewModel: viewModel)
    }
}
