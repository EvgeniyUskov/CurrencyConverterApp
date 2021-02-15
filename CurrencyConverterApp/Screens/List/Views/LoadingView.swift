//
//  LoadingView.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import UIKit

public class LoadingView: UIView {
    //MARK: Views
    lazy var overlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.alpha = 0
        return view
    }()
    
    var activityIndicator = UIActivityIndicatorView()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func showLoading() {
        guard let window = UIApplication.shared.windows.first else { return}
        
        overlay.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlay.center = CGPoint(x: window.frame.width / 2.0, y: window.frame.height / 2.0)
        overlay.clipsToBounds = true
        overlay.layer.cornerRadius = 10
        overlay.alpha = 0.4
        overlay.backgroundColor = Constants.Colors.textColor
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .large
        activityIndicator.center = CGPoint(x: overlay.bounds.width / 2, y: overlay.bounds.height / 2)
        activityIndicator.color = Constants.Colors.backgroundColor
        
        overlay.addSubview(activityIndicator)
        window.addSubview(overlay)
        
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.overlay.alpha = 1
        })
    }
    
    public func hideLoading() {
        UIView.animate(withDuration: 0.25, animations: {
            self.overlay.alpha = 0
        }) { (_) in
            self.overlay.removeFromSuperview()
        }
        activityIndicator.stopAnimating()
        overlay.removeFromSuperview()
    }
}
