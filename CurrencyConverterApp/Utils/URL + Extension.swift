//
//  URL + Extension.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 10/02/2021.
//

import Foundation

extension URL {
    static func getConversionUrl(coversionDirective: ConversionDirective) -> URL? {
        guard let url = URL(string: "\(Constants.Urls.defaultApiUrl)\(Constants.Urls.convertApiUrl)\(coversionDirective.fromCurrencyId.value)_\(coversionDirective.toCurrencyId.value)\(Constants.Urls.convertParametersApiUrl)\(Constants.Urls.api_key)") else {return nil}
        return url
    }
    
    static func getCurrenciesUrl() -> URL? {
        guard let url = URL(string: "\(Constants.Urls.defaultApiUrl)\(Constants.Urls.currenciesApiUrl)\(Constants.Urls.api_key)") else {return nil}
        return url
    }
}
