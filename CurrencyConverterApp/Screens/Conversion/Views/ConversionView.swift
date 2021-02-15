//
//  ConvertionView.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa

//MARK: enums
public enum Element{
    case from
    case to
}

//MARK: ConversionView
public class ConversionView: UIView {
    //MARK: Properties
    var viewControllerDelegate: ConversionViewDelegate?
    
    var disposeBag = DisposeBag()
    
    //MARK: Views
    //MARK: Currency from
    lazy var fromButton: UIButton = {
        let button = UIButton.makeButton()
        button.addTarget(self, action: #selector(fromCurrencyTapped), for: .touchUpInside)
        return button
    }()
    lazy var fromTextField: UITextField = {
        return UITextField.makeTextField()
    }()
    lazy var fromStackView: UIStackView = {
        let stackView = UIStackView.makeHorizontalStackView(views: [fromButton,
                                                                    fromTextField])
        stackView.spacing = 5
        return stackView
    }()
    
    //MARK: Currency to
    lazy var toButton: UIButton = {
        let button = UIButton.makeButton()
        button.addTarget(self, action: #selector(toCurrencyTapped), for: .touchUpInside)
        return button
    }()
    lazy var toTextField: UITextField = {
        return UITextField.makeTextField()
    }()
    lazy var toStackView: UIStackView = {
        let stackView = UIStackView.makeHorizontalStackView(views: [toButton,
                                                                    toTextField])
        stackView.spacing = 5
        return stackView
    }()
    
    //Global stackview
    lazy var globalStackView: UIStackView = {
        let stackView = UIStackView.makeVerticalStackView(views: [fromStackView,
                                                                  toStackView])
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: Init
    init(viewController: ConversionViewDelegate) {
        super.init(frame: UIScreen.main.bounds)
        self.viewControllerDelegate = viewController
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    @objc
    private func fromCurrencyTapped() {
        viewControllerDelegate?.navigateToFromCurrency()
    }
    
    @objc
    private func toCurrencyTapped() {
        viewControllerDelegate?.navigateToToCurrency()
    }
    
    //MARK: configure
    func configure(with viewModel: ConversionViewModel) {
        self.fromButton.setTitle(viewModel.rateViewModel?.fromCurrency?.id.value, for: .normal)
        self.toButton.setTitle(viewModel.rateViewModel?.toCurrency?.id.value, for: .normal)
    }
    
}

//MARK: setup
extension ConversionView {
    
    private func setupView() {
        setupReactions()
        
        addSubview(globalStackView)
        
        fromButton.widthToSuperview(fromStackView.widthAnchor, multiplier: 0.25)
        toButton.widthToSuperview(toStackView.widthAnchor, multiplier: 0.25)
        globalStackView.edgesToSuperview(insets: .top(20) + .left(20) + .bottom(20) + .right(20))
    }
    
    private func setupReactions() {
        setupEditingDidBegin()
        setupEditingChanged()
        setupEditingDidEndOnExit()
    }
    
    private func setupEditingDidBegin() {
        self.fromTextField.rx.controlEvent(.editingDidBegin)
            .asObservable()
            .map{ self.fromTextField.text }
            .subscribe(onNext: {
                [weak self]
                _ in
                self?.toTextField.text = ""
            }).disposed(by: disposeBag)
        
        self.toTextField.rx.controlEvent(.editingDidBegin)
            .asObservable()
            .map{ self.fromTextField.text }
            .subscribe(onNext: {
                [weak self]
                _ in
                self?.fromTextField.text = ""
            }).disposed(by: disposeBag)
    }
    
    private func setupEditingChanged() {
    self.fromTextField.rx.controlEvent(.editingChanged)
        .asObservable()
        .map{ self.fromTextField.text }
        .subscribe(onNext: {
            [weak self]
            value in
            self?.setValue(value: value, forDirection: .upToDown)
        }).disposed(by: disposeBag)
    
    self.toTextField.rx.controlEvent(.editingChanged)
        .asObservable()
        .map{ self.toTextField.text }
        .subscribe(onNext: {
            [weak self]
            value in
            self?.setValue(value: value, forDirection: .downToUp)
        }).disposed(by: disposeBag)
    }
    
    private func setupEditingDidEndOnExit() {
    self.fromTextField.rx.controlEvent(.editingDidEndOnExit)
        .asObservable()
        .map{ self.fromTextField.text }
        .subscribe(onNext: {
            [weak self]
            value in
            self?.setValue(value: value, forDirection: .upToDown)
        }).disposed(by: disposeBag)
    
    self.toTextField.rx.controlEvent(.editingDidEndOnExit)
        .asObservable()
        .map{ self.toTextField.text }
        .subscribe(onNext: {
            [weak self]
            value in
            self?.setValue(value: value, forDirection: .downToUp)
        }).disposed(by: disposeBag)
    }
}

//MARK: Additional methods
extension ConversionView {
    
    func calculateAmountForEmptyField() {
        switch getNonEmptyField() {
        case .to:
            setValue(value: toTextField.text, forDirection: .downToUp)
        default:
            setValue(value: fromTextField.text, forDirection: .upToDown)
        }
    }
    
    public func getNonEmptyField() -> Element? {
        guard let fromIsEmpty = fromTextField.text?.isEmpty,
              let _ = viewControllerDelegate?.viewModel?.rateViewModel?.fromCurrency,
              let toIsEmpty = toTextField.text?.isEmpty,
              let _ = viewControllerDelegate?.viewModel?.rateViewModel?.toCurrency
        else {return nil}
        if fromIsEmpty && !toIsEmpty {
            return .to
        } else {
            if !fromIsEmpty && toIsEmpty {
                return .from
            }
        }
        return nil
    }

    private func setValue(value: String?, forDirection direction: ConversionDirection) {
        switch direction{
        case .upToDown:
            if let value = value,
               let count = Float(value),
               let rate = self.viewControllerDelegate?.viewModel?.rateViewModel?.conversionRate,
               let result = self.viewControllerDelegate?.interactor?.calculateAmount(for: count,
                                                                                      rate: rate,
                                                                                      direction: direction) {
                self.toTextField.text = String(format: "%.2f", result)
            } else {
                self.toTextField.text = ""
            }
        case .downToUp:
            if let value = value,
               let count = Float(value),
               let rate = self.viewControllerDelegate?.viewModel?.rateViewModel?.conversionRate,
               let result = self.viewControllerDelegate?.interactor?.calculateAmount(for: count,
                                                                                      rate: rate,
                                                                                      direction: direction) {
                self.fromTextField.text = String(format: "%.2f", result)
            } else {
                self.fromTextField.text = ""
            }
        }
        
    }
}
