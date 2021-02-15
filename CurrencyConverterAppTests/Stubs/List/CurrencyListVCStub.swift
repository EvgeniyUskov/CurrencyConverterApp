//
//  CurrencyListVCStub.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import UIKit
@testable import CurrencyConverterApp


public class CurrencyListVCStub: UITableViewController {
    //MARK: Properties
    var viewModel: CurrencyListViewModel?
    
    //MARK: Init
    public init(viewModel: CurrencyListViewModel) {
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

extension CurrencyListVCStub: ListViewControllerRoutingProtocol {
    
}

extension CurrencyListVCStub: ListViewControllerProtocol {
    public func displayData(currencyViewModels: [CurrencyViewModel]) {
        viewModel?.currencyViewModels = currencyViewModels
    }
}
