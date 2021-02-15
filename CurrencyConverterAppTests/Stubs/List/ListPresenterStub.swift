//
//  ListPresenterStub.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import Foundation
@testable import CurrencyConverterApp

public class ListPresenterStub {
    //MARK: Properties
    weak var viewController: ListViewControllerProtocol?
    
    //MARK: Init
    public init(viewController: ListViewControllerProtocol) {
        self.viewController = viewController
    }
    
}

//MARK: ListPresenterProtocol Implementation
extension ListPresenterStub: ListPresenterProtocol {
    public func presentData(currencies: [Currency]) {
        let currencyViewModels = currencies.map {
            CurrencyViewModel(currency: $0)
        }
        viewController?.displayData(currencyViewModels: currencyViewModels.sorted())
    }
}
