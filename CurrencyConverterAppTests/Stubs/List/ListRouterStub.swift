//
//  ListRouterStub.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import Foundation
@testable import CurrencyConverterApp

//MARK: ListRouter
public class ListRouterStub {
    var viewController: ListViewControllerRoutingProtocol?
    
    //MARK: Init
    init(viewController: ListViewControllerRoutingProtocol) {
        self.viewController = viewController
    }
}

extension ListRouterStub: ListRouterProtocol {
    
}
