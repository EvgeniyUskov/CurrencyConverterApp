//
//  CurrenciesViewModel.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

public class CurrencyListViewModel {
    
    //MARK: Properties
    
    var currencyViewModels: [CurrencyViewModel]?
    var selectedCurrencySubject = PublishSubject<Currency>()
    var selectedCurrencyObservable: Observable<Currency> {
        return selectedCurrencySubject.asObservable()
    }
       
    func selectRow(forIndexPath indexPath: IndexPath) {
        guard let currencyViewModels = currencyViewModels else {return}
        selectedCurrencySubject.onNext(currencyViewModels[indexPath.row].currency)
//        selectedCurrencySubject.onCompleted()
    }
    
}
