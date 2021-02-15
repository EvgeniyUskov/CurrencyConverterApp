//
//  CurrencyRate.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import Foundation


public struct RateList : Decodable{
    var rates: [CurrencyRate]
}

public struct CurrencyRate : Decodable{
    let currencyConversionId: String
    let conversionRate: Float
    
    public init(currencyConversionId: String, conversionRate: Float) {
        self.currencyConversionId = currencyConversionId
        self.conversionRate = conversionRate
    }
}
