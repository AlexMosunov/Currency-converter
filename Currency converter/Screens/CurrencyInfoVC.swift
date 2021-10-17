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
    
//    var tableView = UITableView()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, CurrencyPairMonobank>!
    
    var currencyPairsArray: [CurrencyPairMonobank] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureCollectionView()
//        configureTableView()
        fetchDataWithAlamofire()
        configureDataSource()
    }
    
    
    // MARK: Fetching data
    
    func fetchDataWithAlamofire() {
//        activityIndicator.startAnimating()
        AlamofireNetworkRequest.sendRequest(url: Constants.Mono.getAllCurrencyExchanges, apiType: .monoBank) { currencyPairs in
            guard let currencyPairs = currencyPairs as? [CurrencyPairMonobank] else { return }
            let uahCurrencyCode = 980
            // only get pairs with base uah currency
            self.currencyPairsArray = currencyPairs.filter { $0.currencyCodeB == uahCurrencyCode }
            self.updateData()
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemTeal
        collectionView.register(CurrencyExchangeCVC.self, forCellWithReuseIdentifier: CurrencyExchangeCVC.reuseID)
    }
    
    func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 8
        let minItemSpacing: CGFloat = 6
        let availableWidth = width - (padding * 2) - (minItemSpacing * 2)
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 100)
        
        return flowLayout
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
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
    
//    func configureTableView() {
//        view.addSubview(tableView)
//        setTableViewDelegates()
//        tableView.rowHeight = 30
//        tableView.pin(to: self.view)
//    }
//
//    func setTableViewDelegates() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//


}

//
//extension CurrencyInfoVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//
//
//}

