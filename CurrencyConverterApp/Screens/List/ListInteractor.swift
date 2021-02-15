//
//  ListInteractor.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 10/02/2021.
//

import Foundation

//MARK: Protocols
public protocol ListInteractorProtocol: AnyObject {
    func showCurrencies(with searchTerm: String?)
}

//MARK: ListInteractor
public class ListInteractor {
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
extension ListInteractor: ListInteractorProtocol {
    public func showCurrencies(with searchTerm: String? = nil) {
        
        storageManager?.loadCurrencyCachedEntities(with: searchTerm, completionHandler: {
            [weak self]
            currencyCachedEntities in
            if currencyCachedEntities.isEmpty {
                self?.networkManager?.fetchCurrencyList(completionHandler: {
                    currencies in
                    let entities = currencies.compactMap {
                        [weak self]
                        currency -> CurrencyCachedEntity? in
                        let entity = self?.storageManager?.createCurrencyChachedEntity()
                        if let entity = entity {
                            self?.fillEntity(entity, with: currency)
                            return entity
                        }
                        return nil
                    }
                    self?.storageManager?.saveCurrencyCachedEntities(entities, completionHandler: {
                        self?.presenter?.presentData(currencies: currencies)
                    })
                })
            } else {
                let currencies = currencyCachedEntities.compactMap {
                    Currency(from: $0)
                }
                self?.presenter?.presentData(currencies: currencies)
            }
        })
    }
    
    private func fillEntity(_ entity: CurrencyCachedEntity, with currency: Currency) {
        entity.currencyName = currency.currencyName
        entity.currencySymbol = currency.currencySymbol
        entity.id = currency.id
    }

}
