//
//  ConversionViewController.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 04.02.2021.
//

import UIKit
import RxCocoa
import RxSwift

//MARK: Protocols
//Protcol conversionView -> viewController
public protocol ConversionViewDelegate {
    var viewModel: ConversionViewModel? {get set}
    var interactor: ConversionInteractorProtocol? {get}
    func navigateToFromCurrency()
    func navigateToToCurrency()
}
//Protocol presenter -> vewController
public protocol ConversionViewControllerProtocol: AnyObject {
    func displayFromCurrencyData(currencyViewModel: ConversionCurrencyViewModel)
    func displayToCurrencyData(currencyViewModel: ConversionCurrencyViewModel)
    func displayData(viewModel: RateViewModel)
}
//Protcol conversionRouter -> viewController
public protocol ConversionViewControllerRoutingProtocol: AnyObject {
    var conversionView: ConversionView {get}
    func navigateToCurrencyList(viewController: CurrencyListViewController)
}

//MARK: ConversionViewController
public class ConversionViewController: UIViewController {
    //MARK: Views
    lazy public var conversionView = ConversionView(viewController: self)
    
    //MARK: Properties
    public var viewModel: ConversionViewModel?
    
    var presenter: ConversionPresenterProtocol?
    public var interactor: ConversionInteractorProtocol?
    var router: ConversionRouterProtocol?
    
    let disposeBag = DisposeBag()
    
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
        setupView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel
               else {return}
        interactor?.updateRates(for: viewModel.rateViewModel) {
            [weak self] in
            DispatchQueue.main.async {
                self?.conversionView.configure(with: viewModel)
                self?.conversionView.calculateAmountForEmptyField()
            }
        }
        
    }
        
}
//MARK: PresenterProtocol
extension ConversionViewController: ConversionViewControllerProtocol {
    public func displayFromCurrencyData(currencyViewModel: ConversionCurrencyViewModel) {
        viewModel?.rateViewModel?.fromCurrency = currencyViewModel
        conversionView.fromButton.setTitle(self.viewModel?.rateViewModel?.fromCurrency?.id.value, for: .normal)
    }
    
    public func displayToCurrencyData(currencyViewModel: ConversionCurrencyViewModel) {
        viewModel?.rateViewModel?.toCurrency = currencyViewModel
        conversionView.toButton.setTitle(self.viewModel?.rateViewModel?.toCurrency?.id.value, for: .normal)
    }
    
    public func displayData(viewModel: RateViewModel) {
        self.viewModel?.rateViewModel = viewModel
        guard let conversionViewModel = self.viewModel else {
            return
        }
        conversionViewModel.rateViewModel = viewModel
        conversionView.configure(with: conversionViewModel)
    }
    
    
}
//MARK: ViewModel navigation from view
extension ConversionViewController: ConversionViewDelegate {
    public func navigateToFromCurrency() {
        router?.navigateToCurrencyList(senderType: .from)
    }
    
    public func navigateToToCurrency() {
        router?.navigateToCurrencyList(senderType: .to)
    }

}

//MARK: Navigation
extension ConversionViewController: ConversionViewControllerRoutingProtocol {
    public func navigateToCurrencyList(viewController: CurrencyListViewController) {
        self.show(viewController, sender: self)
    }
    
}

//MARK: Additional methods
extension ConversionViewController {
    
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
        view.addSubview(conversionView)
        conversionView.viewControllerDelegate = self
        
        conversionView.center(in: view)
        conversionView.width(to: view)
    }

}
