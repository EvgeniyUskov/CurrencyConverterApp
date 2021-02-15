//
//  ConversionInteractor.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 10/02/2021.
//

import Foundation

//MARK: Protocols
public protocol ConversionInteractorProtocol: AnyObject {
    func calculateAmount(for value: Float, rate: Float, direction: ConversionDirection) -> Float?
    func updateRates(for viewModel: RateViewModel?, completionHandler: @escaping () -> ())
    
    func setFromCurrency(currency: Currency)
    func setToCurrency(currency: Currency)
}

//MARK: ConversionInteractor
public class ConversionInteractor {
    //MARK: Properties
    weak var presenter: ConversionPresenterProtocol?
    var networkManager: NetworkManagerProtocol?
    
    //MARK: Init
    public init(presenter: ConversionPresenterProtocol?, networkManager: NetworkManagerProtocol) {
        self.presenter = presenter
        self.networkManager = networkManager
    }
}

//MARK: ConversionInteractorProtocol implementation
extension ConversionInteractor: ConversionInteractorProtocol {
    public func calculateAmount(for value: Float, rate: Float, direction: ConversionDirection) -> Float? {
        switch direction {
        case .upToDown:
            return value * rate
        case .downToUp:
            return value / rate
        }
    }
    
    public func updateRates(for viewModel: RateViewModel?, completionHandler: @escaping () -> ()) {
        guard let toViewModel = viewModel,
              let _ = toViewModel.fromCurrency,
              let _ = toViewModel.toCurrency
        else { return }
            guard let conversionDirective = ConversionDirective(from: toViewModel) else {return}
            self.fetchRates(conversionDirective: conversionDirective,
                            completionHandler: {
                                (rate) in
                                viewModel?.setRate(currencyRate: rate)
                                completionHandler()
                            })
    }
    
    public func fetchRates(conversionDirective: ConversionDirective,
                           completionHandler: @escaping ((CurrencyRate) -> () ))  {
        networkManager?.fetchCurrencyRates(conversionDirective: conversionDirective,
                                           completionHandler: {
                                            completionHandler($0[0])
                                           })
    }
    
    public func setFromCurrency(currency: Currency) {
        presenter?.presentFromCurrency(currency: currency)
    }
    
    public func setToCurrency(currency: Currency) {
        presenter?.presentToCurrency(currency: currency)
    }
}

