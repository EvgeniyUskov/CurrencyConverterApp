//
//  CurrencyViewController.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 04.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

public protocol ListViewControllerRoutingProtocol: AnyObject {
    
}

public protocol ListViewControllerProtocol: AnyObject {
    func displayData(currencyViewModels: [CurrencyViewModel])
}

public class CurrencyListViewController: UITableViewController {
    //MARK: Properties
    var viewModel: CurrencyListViewModel?
    var presenter: ListPresenterProtocol?
    public var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?
    
    private var timer : Timer?
    
    //MARK: Views
    let searchController = UISearchController(searchResultsController: nil)
    let loadingView = LoadingView()
    //MARK: Init
    public init(viewModel: CurrencyListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.showLoading()
        setupNavBar()
        setupTableView()
        setupSearchBar()
        interactor?.showCurrencies(with: nil)
    }
    
    private func setupNavBar() {
        self.navigationItem.title = Constants.Stuff.currenciesHeaderText
    }
    private func setupTableView() {
        tableView.backgroundColor = Constants.Colors.backgroundColor
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: Constants.Ids.currencyCellReuseId)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Constants.Stuff.currencyPlaceHolder
        UIHelper.setupSearchBarUI(searchBar: searchController.searchBar)
    }
}

extension CurrencyListViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.currencyViewModels == nil ||
            viewModel?.currencyViewModels?.count == 0 {
            self.tableView.setEmptyView(title: Constants.Stuff.noDataTitleMessage, message: Constants.Stuff.noDataSubtitleMessage)
        } else {
            self.tableView.restore()
        }
        return viewModel?.currencyViewModels?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = viewModel?.currencyViewModels?[indexPath.row] else { return UITableViewCell()}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Ids.currencyCellReuseId, for: indexPath) as! CurrencyCell
        cell.configure(with: cellData)
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectRow(forIndexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
        //        dismiss(animated: true, completion: nil)
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

//MARK: SearchBarDeegate Implementation
extension CurrencyListViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchTerm: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                                        self.interactor?.showCurrencies(with: searchTerm)
        })
    }
}

extension CurrencyListViewController: ListViewControllerRoutingProtocol {
    
}

extension CurrencyListViewController: ListViewControllerProtocol {
    public func displayData(currencyViewModels: [CurrencyViewModel]) {
        viewModel?.currencyViewModels = currencyViewModels
        DispatchQueue.main.async {
            [weak self] in
            self?.tableView.reloadData()
            self?.loadingView.hideLoading()
        }
    }
}
