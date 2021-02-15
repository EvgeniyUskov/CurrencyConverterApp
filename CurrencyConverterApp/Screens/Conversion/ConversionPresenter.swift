//
//  ConversionPresenter.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 10/02/2021.
//

import Foundation


//MARK: Protocols
public protocol ConversionPresenterProtocol: AnyObject {
    func presentFromCurrency(currency: Currency)
    func presentToCurrency(currency: Currency)
}

public class ConversionPresenter {
    //MARK: Properties
    weak var viewController: ConversionViewControllerProtocol?
    
    //MARK: Init
    public init(viewController: ConversionViewControllerProtocol) {
        self.viewController = viewController
    }
    
}

//MARK: ConversionPresenterProtocol Implementation
extension ConversionPresenter: ConversionPresenterProtocol {
    public func presentFromCurrency(currency: Currency) {
        let currencyViewModel = ConversionCurrencyViewModel(currency: currency)
        viewController?.displayFromCurrencyData(currencyViewModel: currencyViewModel)
    }
    
    public func presentToCurrency(currency: Currency) {
        let currencyViewModel = ConversionCurrencyViewModel(currency: currency)
        viewController?.displayToCurrencyData(currencyViewModel: currencyViewModel)
    }
    
}
