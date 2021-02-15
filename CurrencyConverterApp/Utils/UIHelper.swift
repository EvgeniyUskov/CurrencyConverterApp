//
//  UIHelper.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 04.02.2021.
//

import Foundation
import UIKit

public class UIHelper {
    
    public static func setupNavigationControllerUI(for navigationController: UINavigationController) {
        guard let textColor = Constants.Colors.textColor else { return }
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: textColor]
        navigationController.navigationBar.tintColor = Constants.Colors.textColor
    }
    
    public static func setupSearchBarUI(searchBar: UISearchBar) {
        searchBar.barTintColor = Constants.Colors.backgroundColor
        searchBar.tintColor = Constants.Colors.textColor
        searchBar.textField?.textColor = Constants.Colors.textColor
        searchBar.searchBarStyle = .minimal
    }

}
