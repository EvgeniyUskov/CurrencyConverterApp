//
//  CurrencyViewModel.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import Foundation
import RxSwift
import RxCocoa

public class CurrencyViewModel: CurrencyBaseViewModel {
}


//
//  CurrencyViewModel.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

//import Foundation
//import RxSwift
//import RxCocoa
//
//public class CurrencyViewModel {
//    var currency: Currency
//
//    var currencyName: String
//    var currencySymbol: String?
//    var id: String
//
//    var description: String {
//        return "\(self.id) - \(self.currencyName)"
//    }
//
//    var disposeBag = DisposeBag()
//
//    public init(currency: Currency) {
//        self.currency = currency
//
//        self.currencyName = currency.currencyName
//            .asObservable()
//            .subscribe(onNext: {
//            [weak self]
//            value in
//            self?.currencyName = value
//        }).disposed(by: disposeBag)
//
//        self.currencySymbol = currency.currencySymbol
//            .asObservable()
//            .subscribe(onNext: {
//                        [weak self]
//                        value in
//
//            })
//        if let symbol = currency.currencySymbol {
//            self.currencySymbol = symbol
//        }
//        self.id = currency.id
//    }
//
//}
//
//extension CurrencyViewModel: Comparable {
//    public static func < (lhs: CurrencyViewModel, rhs: CurrencyViewModel) -> Bool {
//        return lhs.description < rhs.description
//    }
//
//    public static func <= (lhs: CurrencyViewModel, rhs: CurrencyViewModel) -> Bool {
//        return lhs.description <= rhs.description
//    }
//
//    public static func == (lhs: CurrencyViewModel, rhs: CurrencyViewModel) -> Bool {
//        return lhs.description == rhs.description
//    }
//
//    public static func > (lhs: CurrencyViewModel, rhs: CurrencyViewModel) -> Bool {
//        return lhs.description > rhs.description
//    }
//
//    public static func >= (lhs: CurrencyViewModel, rhs: CurrencyViewModel) -> Bool {
//        return lhs.description >= rhs.description
//    }
//}
