//
//  PersonalBudgetVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 26.10.2021.
//

import UIKit

class PersonalBudgetVC: UIViewController {
    
    //MARK: Properties
    
    private var tableView: UITableView!
    private var model = PersonalBudgetModel()
    
    // total amount of spendings
    private var totalAmount: String?
    
    // timer
    private var timer: Timer?
    private var readyForRefresh = true
    
    // user defaults
    private let userTokenString = "userToken"
    private let defaults = UserDefaults.standard
    

    //MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButtonTapped))
    }
    
    
    //MARK: Private funcs
    
    private func configureTableView() {
        tableView = UITableView(frame: self.view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight  = 50
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        sendRequestForUserTransactions()
    }
    
    private func sendRequestForUserTransactions() {
        if readyForRefresh {
            readyForRefresh = false
            timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false) { timer in
                print("Timer fired!")
                self.readyForRefresh = true
            }
        } else {
            let timeLeft = timer != nil ?
                           Int(Date(timeInterval: 0,
                                    since: timer!.fireDate)
                                    .timeIntervalSinceNow) :
                           60
            
            AlertController.showError(message: "Please wait \(String(timeLeft)) seconds before refreshing", on: self)
            return
        }
        
        
        
        if let userToken = defaults.string(forKey: userTokenString) {
            self.getUserTransactions(userToken)
            return
        }
        
        AlertController.showUserDataInput(viewController: self) { userToken in
            self.getUserTransactions(userToken)
        }
    }
    
    private func getUserTransactions(_ userToken: String) {
        self.view.showActivityIndicator()
        AlamofireNetworkRequest.getUserTransactions(url: Constants.Mono.getUserTransactions, token: userToken) { [weak self] result in
            
            switch result {
            case .failure(let error):
                AlertController.showError(message: error.localizedDescription, on: self)
                
            case .success(let userTransactions):
                guard let self = self else { return }
                self.totalAmount = self.model.fetchUserTransactions(userTransactions)
                self.title = "Total: \(self.totalAmount ?? "") UAH"
                
                self.defaults.set(userToken, forKey: self.userTokenString)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                                             target: self,
                                                                             action: #selector(self.actionButtonTapped))
                }
            }
            self?.view.removeActivityIndicator()
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

extension PersonalBudgetVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category     = model.categoriesWithValue[indexPath.row]
        let transactions = model.transactionsPerCategory[category]
        
        if transactions != nil {
            let destVC          = BudgetCategoryInfoVC()
            destVC.transactions = transactions
            destVC.category     = category
            let navController   = UINavigationController(rootViewController: destVC)
            present(navController, animated: true)
        }
    }
}
