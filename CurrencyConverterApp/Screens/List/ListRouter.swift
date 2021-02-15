//
//  ListRouter.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 10/02/2021.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: Protocols
public protocol ListRouterProtocol {
}

//MARK: ListRouter
public class ListRouter {
    var viewController: ListViewControllerRoutingProtocol?
    
    //MARK: Init
    init(viewController: ListViewControllerRoutingProtocol) {
        self.viewController = viewController
    }
}

extension ListRouter: ListRouterProtocol {
    
}

