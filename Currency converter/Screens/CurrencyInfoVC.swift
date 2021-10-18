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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
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
            self.updateData()
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
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CurrencyPairMonobank>()
        snapshot.appendSections([.main])
        snapshot.appendItems(currencyPairsArray)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
}

