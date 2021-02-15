//
//  ConversionRouter.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 08.02.2021.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: Protocols
public protocol ConversionRouterProtocol {
    func navigateToCurrencyList(senderType: Element)
}

//MARK: ConversionRouter
public class ConversionRouter {
    let disposeBag = DisposeBag()
    weak var viewController: ConversionViewControllerRoutingProtocol?
    var interactor: ConversionInteractorProtocol?
    
    //MARK: Init
    init(viewController: ConversionViewControllerRoutingProtocol, interactor: ConversionInteractorProtocol) {
        self.viewController = viewController
        self.interactor = interactor
    }
    
}

extension ConversionRouter: ConversionRouterProtocol {
    public func navigateToCurrencyList(senderType: Element) {
        let listViewController = ListBuilder().build()
        
        listViewController.viewModel?.selectedCurrencyObservable.subscribe(onNext: {
            [weak self]
            currency in
            switch senderType {
            case .from:
                self?.interactor?.setFromCurrency(currency: currency)
            case .to:
                self?.interactor?.setToCurrency(currency: currency)
            }
            }).disposed(by: disposeBag)
    
        viewController?.navigateToCurrencyList(viewController: listViewController)
    }
    
}
