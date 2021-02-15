//
//  UIButton + Extension.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 08.02.2021.
//

import UIKit

extension UIButton {
    static func makeButton() -> UIButton {
       let button = UIButton()
        button.backgroundColor = Constants.Colors.textColor
        button.tintColor = Constants.Colors.backgroundColor
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Stuff.chooseCurrencyText, for: .normal)
        button.setTitleColor(Constants.Colors.backgroundColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        
        button.layer.cornerRadius = 5
        return button
    }
}
