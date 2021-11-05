//
//  CurrencyVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 31.08.2021.
//

import UIKit

class CurrencyInfoVC: UIViewController {
    
    enum Section {
        case main
    }
    
    private let currenciesModel = CurrenciesExchangesModel.shared
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, CurrencyDataParsed>!
    
    private var currencyPairsArray: [CurrencyDataParsed] = []
    private var filteredCurrencyPairsArray: [CurrencyDataParsed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
        configureSearchController()
        fetchDataWithAlamofire()
        configureDataSource()
    }
    
    // MARK: Fetching data
    
    func fetchDataWithAlamofire() {
        self.view.showActivityIndicator()
        AlamofireNetworkRequest.sendRequest(url: Constants.Mono.getAllCurrencyExchanges,
                                            apiType: .monoBank) { [weak self] result in
            switch result {
            case .failure(let error):
                AlertController.showError(message: error.localizedDescription, on: self)
                
            case .success(let currencyPairs):
                guard let self = self else { return }
                guard let currencyPairsMonobank = currencyPairs as? [CurrencyPairMonobank] else { return }
                
                // only get pairs with base uah currency
                let uahCurrencyCode = 980
                let filteredCurrencyPairs = self.currenciesModel.filterCurrencies(array: currencyPairsMonobank, code: uahCurrencyCode)
                
                // parse data into CurrencyDataParsed
                self.currencyPairsArray = self.currenciesModel.parseCurrencyExchangePairs(from: filteredCurrencyPairs)
                
                self.updateData(on: self.currencyPairsArray)
            }
            self?.view.removeActivityIndicator()
        }
    }
    
    // MARK: Configuring collection view and it's dataSource
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CurrencyExchangeCVC.self, forCellWithReuseIdentifier: CurrencyExchangeCVC.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CurrencyDataParsed>(collectionView: collectionView,
                                                                                       cellProvider: { collectionView, indexPath, currencyPair in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyExchangeCVC.reuseID, for: indexPath) as! CurrencyExchangeCVC
            cell.set(currencyPair: currencyPair)
            return cell
        })
    }
    
    func updateData(on currencyPairsArray: [CurrencyDataParsed]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CurrencyDataParsed>()
        snapshot.appendSections([.main])
        snapshot.appendItems(currencyPairsArray)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    func configureSearchController() {
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.placeholder                = "Search currency"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }
    
}

//MARK: UISearchResultsUpdating - filter search results

extension CurrencyInfoVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: currencyPairsArray)
            return
        }
        filteredCurrencyPairsArray = currencyPairsArray.filter{
            guard let currencyCodeNameA = $0.currencyCodeNameA else { return false }
            let currencyName = $0.currencyNameA ?? ""
            return (
                currencyCodeNameA
                .lowercased()
                .contains(filter.lowercased())
                ||
                currencyName
                .lowercased()
                .contains(filter.lowercased())
            )}
        updateData(on: filteredCurrencyPairsArray)
    }
}
