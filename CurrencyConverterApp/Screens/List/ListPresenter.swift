//
//  ListPresenter.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 10/02/2021.
//


import Foundation

//MARK: Protocols
public protocol ListPresenterProtocol: AnyObject {
    func presentData(currencies: [Currency])
}

public class ListPresenter {
    //MARK: Properties
    weak var viewController: ListViewControllerProtocol?
    
    //MARK: Init
    public init(viewController: ListViewControllerProtocol) {
        self.viewController = viewController
    }
    
}

//MARK: ListPresenterProtocol Implementation
extension ListPresenter: ListPresenterProtocol {
    public func presentData(currencies: [Currency]) {
        let currencyViewModels = currencies.map {
            CurrencyViewModel(currency: $0)
        }
        viewController?.displayData(currencyViewModels: currencyViewModels.sorted())
    }
}
