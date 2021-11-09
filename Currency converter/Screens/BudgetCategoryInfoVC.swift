//
//  BudgetCategoryInfoVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 05.11.2021.
//

import UIKit

class BudgetCategoryInfoVC: UIViewController {
    
    private var tableView: UITableView!
    var transactions: [UserTransaction]?
    var category: PersonalBudgetModel.Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        cancelButton.tintColor = .label
        navigationItem.rightBarButtonItem = cancelButton
        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: self.view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.rowHeight  = 50
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        if let category = category {
            self.title = category.rawValue
        }
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension BudgetCategoryInfoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID, for: indexPath) as? TableViewCell else {
            fatalError("TableViewCell cannot be created")
        }
        if let transaction = transactions?[indexPath.row] {
            let description = transaction.description ?? ""
            let transactionAmount = String(Int(transaction.amount! / 100))
            cell.set(leftText: description, rightText: transactionAmount)
        }

        return cell
    }
    
    
}
