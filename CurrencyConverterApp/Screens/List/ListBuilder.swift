//
//  ListBuilder.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import Foundation

public class ListBuilder {
    public func build() -> CurrencyListViewController {
        let networkManager = NetworkManager()
        let storageManager = StorageManager()
        let viewModel = CurrencyListViewModel()
        
        let viewController = CurrencyListViewController(viewModel: viewModel)
        
        let presenter = ListPresenter(viewController: viewController)
        let interactor = ListInteractor(presenter: presenter,
                                        networkManager: networkManager,
                                        storageManager: storageManager)
        let router = ListRouter(viewController: viewController)

        viewController.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
