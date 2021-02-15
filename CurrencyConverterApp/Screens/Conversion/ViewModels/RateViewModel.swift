//
//  RateViewModel.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: protocols
public protocol RateViewModelProtocol {
    var conversionRate: Float? {get}
    var currencyConversionId: String? {get}
    
    var fromCurrency: ConversionCurrencyViewModel? {get set}
    var toCurrency: ConversionCurrencyViewModel? {get set}
    
    func setRate(currencyRate: CurrencyRate)
}

public class RateViewModel: RateViewModelProtocol {
    var currencyRate: CurrencyRate?
    
    public var conversionRate: Float?
    public var currencyConversionId: String?
    
    public var fromCurrency: ConversionCurrencyViewModel?
    public var toCurrency: ConversionCurrencyViewModel?
    
    public func setRate(currencyRate: CurrencyRate) {
        self.currencyRate = currencyRate
  
        self.currencyConversionId = currencyRate.currencyConversionId
        self.conversionRate = currencyRate.conversionRate
    }
}
