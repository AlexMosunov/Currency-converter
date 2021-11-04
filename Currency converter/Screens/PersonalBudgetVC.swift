//
//  PersonalBudgetVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 26.10.2021.
//

import UIKit

class PersonalBudgetVC: UIViewController {
    
    private var tableView: UITableView!
    private var model = PersonalBudgetModel()
    private var totalAmount: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButtonTapped))
    }
    
    
    private func configureTableView() {
        tableView = UITableView(frame: self.view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        sendRequestForUserTransactions()
    }
    
    private func sendRequestForUserTransactions() {
        AlertController.showUserDataInput(viewController: self) { userToken in
            self.view.showActivityIndicator()
            AlamofireNetworkRequest.getUserTransactions(url: Constants.Mono.getUserTransactions, token: userToken) { [weak self] result in
                
                switch result {
                case .failure(let error):
                    AlertController.showError(message: error.localizedDescription, on: self)
                    
                case .success(let userTransactions):
                    guard let self = self else { return }
                    self.totalAmount = self.model.fetchUserTransactions(userTransactions)
                    self.title = "Total: \(self.totalAmount ?? "") UAH"
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.navigationItem.rightBarButtonItem = nil
                    }
                }
                self?.view.removeActivityIndicator()
            }
        }
    }
    
    
    @objc func actionButtonTapped() {
        sendRequestForUserTransactions()
    }

}

// MARK: UITableViewDataSource

extension PersonalBudgetVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.amountPerCategory.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID, for: indexPath) as? TableViewCell else {
            fatalError("TableViewCell cannot be created")
        }
        let category = model.categoriesWithValue[indexPath.row]
        let amountPerCategory = Int(model.amountPerCategory[category] ?? 0)
        cell.set(leftText: category.rawValue, rightText: String(amountPerCategory))
        
        return cell
    }
    
    
}
