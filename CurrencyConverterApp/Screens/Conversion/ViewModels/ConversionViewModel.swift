//
//  ConversionViewModel.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 08.02.2021.
//

import Foundation
//MARK: enums
public enum ConversionDirection {
    case upToDown
    case downToUp
}

//MARK: ConversionViewModel
public class ConversionViewModel {
    //MARK: Properties
    public var rateViewModel: RateViewModel?
    
    //MARK: Init
    init() {
        rateViewModel = RateViewModel()
    }
}

