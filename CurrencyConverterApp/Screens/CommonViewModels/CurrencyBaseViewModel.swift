//
//  CurrencyBaseViewModel.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 12/02/2021.
//

import Foundation
import RxSwift
import RxCocoa

public class CurrencyBaseViewModel {
    var currency: Currency
    
    var disposeBag = DisposeBag()
    
    public init(currency: Currency) {
        self.currency = currency
    }
}

extension CurrencyBaseViewModel {
    var currencyName: BehaviorRelay<String> {
        return BehaviorRelay<String>(value: currency.currencyName)
    }
    
    var currencySymbol: BehaviorRelay<String?> {
        return BehaviorRelay<String?>(value: currency.currencySymbol)
    }

    var id: BehaviorRelay<String> {
        return BehaviorRelay<String>(value: currency.id)
    }
    
    var description: String {
        return "\(self.id.value) - \(self.currencyName.value)"
    }
    
}

extension CurrencyBaseViewModel: Comparable {
    public static func < (lhs: CurrencyBaseViewModel, rhs: CurrencyBaseViewModel) -> Bool {
        return lhs.description < rhs.description
    }
    
    public static func <= (lhs: CurrencyBaseViewModel, rhs: CurrencyBaseViewModel) -> Bool {
        return lhs.description <= rhs.description
    }
    
    public static func == (lhs: CurrencyBaseViewModel, rhs: CurrencyBaseViewModel) -> Bool {
        return lhs.description == rhs.description
    }
    
    public static func > (lhs: CurrencyBaseViewModel, rhs: CurrencyBaseViewModel) -> Bool {
        return lhs.description > rhs.description
    }
    
    public static func >= (lhs: CurrencyBaseViewModel, rhs: CurrencyBaseViewModel) -> Bool {
        return lhs.description >= rhs.description
    }
}
