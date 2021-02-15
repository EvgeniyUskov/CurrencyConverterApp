//
//  CurrencyCell.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import UIKit
import TinyConstraints

class CurrencyCell: UITableViewCell {
    
    private lazy var currencylabel: UILabel = {
        let label = UILabel.makeCurrencyLabel()
        return label
    }()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: Setup
    public func setup() {
        contentView.backgroundColor = Constants.Colors.backgroundColor
        contentView.addSubview(currencylabel)
        
        currencylabel.edgesToSuperview(insets: .left(30), usingSafeArea: true)
    }
    
    //MARK: Configure
    public func configure(with viewModel: CurrencyViewModel) {
        currencylabel.text = "\(viewModel.description)"
    }
}
