//
//  ConversionDirective.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 10/02/2021.
//

import Foundation
import RxSwift
import RxCocoa

public struct ConversionDirective {
    var fromCurrencyId: BehaviorRelay<String>
    var toCurrencyId: BehaviorRelay<String>
    
    init?(from viewModel: RateViewModelProtocol) {
        guard let fromCurrencyId = viewModel.fromCurrency?.id,
              let toCurrencyId = viewModel.toCurrency?.id else {return nil}
        self.fromCurrencyId = fromCurrencyId
        self.toCurrencyId = toCurrencyId
    }
}
