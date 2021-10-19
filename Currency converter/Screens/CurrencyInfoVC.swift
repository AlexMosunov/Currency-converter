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
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, CurrencyPairMonobank>!
    
    var currencyPairsArray: [CurrencyPairMonobank] = []
    var filteredCurrencyPairsArray: [CurrencyPairMonobank] = []
    
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
//        activityIndicator.startAnimating()
        AlamofireNetworkRequest.sendRequest(url: Constants.Mono.getAllCurrencyExchanges,
                                            apiType: .monoBank) { [weak self] currencyPairs in
            guard let self = self else { return }
            guard let currencyPairs = currencyPairs as? [CurrencyPairMonobank] else { return }
            let uahCurrencyCode = 980
            // only get pairs with base uah currency
            self.currencyPairsArray = currencyPairs.filter { $0.currencyCodeB == uahCurrencyCode }
            self.updateData(on: self.currencyPairsArray)
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CurrencyExchangeCVC.self, forCellWithReuseIdentifier: CurrencyExchangeCVC.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CurrencyPairMonobank>(collectionView: collectionView,
                                                                                       cellProvider: { collectionView, indexPath, currencyPair in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyExchangeCVC.reuseID, for: indexPath) as! CurrencyExchangeCVC
            cell.set(currencyPair: currencyPair)
            return cell
        })
    }
    
    func updateData(on currencyPairsArray: [CurrencyPairMonobank]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CurrencyPairMonobank>()
        snapshot.appendSections([.main])
        snapshot.appendItems(currencyPairsArray)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search currency"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
}

extension CurrencyInfoVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: currencyPairsArray)
            return
        }
//        guard let currencyCodeA = Utils.tuneCurrencyCode($0.currencyCodeA) else { return }
        filteredCurrencyPairsArray = currencyPairsArray.filter{
            guard let currencyCodeA = Utils.tuneCurrencyCode($0.currencyCodeA) else { return false }
            let currencyCodeNameA = currencyCodeA.toCurrencyCode
            let currencyName = Utils.getCurrencyFullName(code: currencyCodeNameA ) ?? ""
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
