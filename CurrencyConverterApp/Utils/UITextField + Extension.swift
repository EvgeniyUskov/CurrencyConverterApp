//
//  UITextField + extension.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 08.02.2021.
//

import UIKit

extension UITextField {
    static func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Constants.Stuff.titlePlaceholderText
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.textColor = Constants.Colors.textColor
        textField.backgroundColor = Constants.Colors.backgroundColor
        textField.font = Constants.Fonts.dateDetailsFont
        return textField
    }
}
