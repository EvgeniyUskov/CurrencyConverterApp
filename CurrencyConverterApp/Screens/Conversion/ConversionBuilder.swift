//
//  ConversionBuilder.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import Foundation

public class ConversionBuilder {
    public func build() -> ConversionViewController{
        let networkManager = NetworkManager()
        let viewModel = ConversionViewModel()
        
        let viewController = ConversionViewController(viewModel: viewModel)
        
        let presenter = ConversionPresenter(viewController: viewController)
        let interactor = ConversionInteractor(presenter: presenter, networkManager: networkManager)
        let router = ConversionRouter(viewController: viewController, interactor: interactor)

        viewController.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
