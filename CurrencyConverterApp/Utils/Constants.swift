//
//  Constantss.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 04.02.2021.
//
import UIKit

enum Constants {
    
    enum Colors {
        static let backgroundColor = UIColor(named: "BgColor")
        static let textColor = UIColor(named: "TextColor")
        
        static let messageTextColor = UIColor.lightGray
        static let dialogBackgroundColor = UIColor.lightGray
    }
    
    enum Fonts {
        static let messageTitleFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let messageSubtitleFont = UIFont.systemFont(ofSize: 10, weight: .light)
        
        static let titleListFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
        static let dateListFont = UIFont.systemFont(ofSize: 10, weight: .light)
        
        static let titleDetailsFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        static let dateDetailsFont = UIFont.systemFont(ofSize: 15, weight: .light)
        static let textDetailsFont = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    enum Ids {
        static let currencyCellReuseId = "currencyCell"
    }
    
    enum Urls {
        static let api_key = "e07154a5ea23795863e8"
        static let defaultApiUrl = "https://free.currconv.com"
        
        static let convertApiUrl = "/api/v7/convert?q="
        static let convertParametersApiUrl = "&compact=ultra&apiKey="
        
        static let currenciesApiUrl = "/api/v7/currencies?apiKey="
    }
    
    enum Stuff {
        static let noDataTitleMessage = "Нет данных о валютах"
        static let noDataSubtitleMessage = ""
        
        static let titlePlaceholderText = "0.00"
        static let chooseCurrencyText = "Валюта"
        
        static let currencyPlaceHolder = "Валюта"
        static let modelName = "RxCurrencyConverterApp"
        
        static let conversionHeaderText = "Конвертер валют"
        static let currenciesHeaderText = "Выбор валюты"
    }
}

