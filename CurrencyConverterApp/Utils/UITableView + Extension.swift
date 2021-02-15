//
//  UITableView + Extension.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 04.02.2021.
//

import UIKit
import TinyConstraints

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.backgroundColor = Constants.Colors.backgroundColor
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = Constants.Colors.messageTextColor
        titleLabel.font = Constants.Fonts.messageTitleFont
        titleLabel.text = title
        titleLabel.textAlignment = .center
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = Constants.Colors.messageTextColor
        messageLabel.font = Constants.Fonts.messageSubtitleFont
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        let stackView = UIStackView.makeVerticalStackView(views: [titleLabel,
                                                                  messageLabel])
        stackView.spacing = 5
        
        emptyView.addSubview(stackView)

        stackView.top(to: emptyView, offset: 100)
        stackView.centerX(to: emptyView)
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
