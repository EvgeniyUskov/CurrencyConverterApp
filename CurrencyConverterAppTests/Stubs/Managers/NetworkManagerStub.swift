//
//  NetworkManagerStub.swift
//  RxClimaAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import Foundation
@testable import CurrencyConverterApp

public class NetworkManagerStub: NetworkManagerProtocol {
    
    public func fetchCurrencyList(completionHandler: @escaping ([Currency]) -> ()) {
        var array = [Currency]()
        for index in 1...5 {
            let entity = CurrencyCachedEntity()
            entity.id = "foo\(index)"
            entity.currencyName = "fooName\(index)"
            entity.currencySymbol = "fooSymbol\(index)"
            let currency = Currency(from: entity)
            guard let fakeCurrency = currency else {return}
            array.append(fakeCurrency)
        }
        completionHandler(array)
    }
    
    public func fetchCurrencyRates(conversionDirective: ConversionDirective, completionHandler: @escaping ([CurrencyRate]) -> ()) {
        let rate = CurrencyRate(currencyConversionId: "foo1_foo2", conversionRate: 10)
        completionHandler([rate])
    }
}
