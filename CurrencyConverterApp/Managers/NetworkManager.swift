//
//  NetworkManager.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 04.02.2021.
//

import Foundation
import RxSwift
import RxCocoa

public protocol NetworkManagerProtocol {
    func fetchCurrencyList(completionHandler: @escaping ([Currency]) -> ())
    func fetchCurrencyRates(conversionDirective: ConversionDirective, completionHandler: @escaping ([CurrencyRate]) -> ())
}

public class NetworkManager: NetworkManagerProtocol {
    
    private let disposeBag =  DisposeBag()
    
    public  func fetchCurrencyList(completionHandler: @escaping ([Currency]) -> ()) {
        guard let url = URL.getCurrenciesUrl() else {return}
        let resource = Resource<CurrencyList>(url: url)
        
        let _ = URLRequest.load(resource: resource)
            .subscribe { (currencyList) in
                completionHandler(currencyList.asArray)
            } onError: { (error) in
                print(error)
            }
    }
    
    public func fetchCurrencyRates(conversionDirective: ConversionDirective, completionHandler: @escaping ([CurrencyRate]) -> ()) {
        guard let url = URL.getConversionUrl(coversionDirective: conversionDirective) else {return}
        let resource = Resource<RateList>(url: url)
        
        let _ = URLRequest.loadRates(resource: resource)
            .subscribe { (rateList) in
                var arr = [CurrencyRate]()
                for (key, val) in rateList {
                    arr.append(CurrencyRate(currencyConversionId: key, conversionRate: val.floatValue))
                }
                completionHandler(arr)
            } onError: { (error) in
                print(error)
            }
    }
}
