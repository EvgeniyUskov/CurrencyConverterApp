//
//  UILabel + Extension.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import UIKit

extension UILabel {
    
    static func makeCurrencyLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = Constants.Colors.textColor
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }
    
    static func makeCaptionLabel(_ caption: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = caption
        label.setContentHuggingPriority(UILayoutPriority.init(251), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority.init(251), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority.init(751), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority.init(750), for: .vertical)

        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .darkGray
        return label
    }
    
    static func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        
        label.font = Constants.Fonts.dateDetailsFont
        label.textColor = .red
        return label
    }
}
