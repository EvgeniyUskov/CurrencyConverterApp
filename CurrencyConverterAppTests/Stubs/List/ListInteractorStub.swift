//
//  ListInteractorStub.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import Foundation
@testable import CurrencyConverterApp

//MARK: ListInteractorStub
public class ListInteractorStub {
    //MARK: Properties
    weak var presenter: ListPresenterProtocol?
    var networkManager: NetworkManagerProtocol?
    var storageManager: StorageManagerProtocol?
    
    //MARK: Init
    public init(presenter: ListPresenterProtocol?, networkManager: NetworkManagerProtocol, storageManager: StorageManagerProtocol) {
        self.presenter = presenter
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
}

//MARK: ListInteractorProtocol implementation
extension ListInteractorStub: ListInteractorProtocol {
    public func showCurrencies(with searchTerm: String? = nil) {
        storageManager?.loadCurrencyCachedEntities(with: searchTerm, completionHandler: {
            [weak self]
            currencyCachedEntities in
                let currencies = currencyCachedEntities.compactMap {
                    Currency(from: $0)
                }
                self?.presenter?.presentData(currencies: currencies)
            })
    }
}
