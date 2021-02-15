//
//  ConversionVCStub.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import UIKit
import RxCocoa
import RxSwift
@testable import CurrencyConverterApp

//MARK: ConversionViewControllerStub
public class ConversionVCStub: UIViewController {
    
    //MARK: Properties
    public var viewModel: ConversionViewModel?
    
    //MARK: Init
    public init(viewModel: ConversionViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: PresenterProtocol
extension ConversionVCStub: ConversionViewControllerProtocol {
    public func displayFromCurrencyData(currencyViewModel: ConversionCurrencyViewModel) {
        viewModel?.rateViewModel?.fromCurrency = currencyViewModel
    }
    
    public func displayToCurrencyData(currencyViewModel: ConversionCurrencyViewModel) {
        viewModel?.rateViewModel?.toCurrency = currencyViewModel
    }
    
    public func displayData(viewModel: RateViewModel) {
        self.viewModel?.rateViewModel = viewModel
        guard let conversionViewModel = self.viewModel else {
            return
        }
        conversionViewModel.rateViewModel = viewModel
    }
}
//MARK: ViewModel navigation from view
extension ConversionVCStub: ConversionViewDelegate {
    public var interactor: ConversionInteractorProtocol? {
        return nil
    }
    
    public func navigateToFromCurrency() {
    }
    
    public func navigateToToCurrency() {
    }
}

//MARK: Navigation
extension ConversionVCStub: ConversionViewControllerRoutingProtocol {
    public var conversionView: ConversionView {
        get {
            ConversionView()
        }
    }
    
    public func navigateToCurrencyList(viewController: CurrencyListViewController) {
    }
    
}

