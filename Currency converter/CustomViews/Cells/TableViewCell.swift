//
//  TableViewCell.swift
//  Currency converter
//
//  Created by Alex Mosunov on 26.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseID = "TableViewCell"
    let padding: CGFloat = 8
    
    // TODO: use different label for rightLabel
    let titleLabel = CETitleLabel(textAlignment: .center, fontSize: 16)
    let bodyLabel = CEBodyLabel(textAlignment: .center)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLeftLabel()
        configureRightLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(leftText: String, rightText: String?) {
        bodyLabel.text = leftText
        
        if let rightText = rightText {
            titleLabel.text = "\(rightText) UAH"
        }
        
    }
    
    private func configureLeftLabel() {
        addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            bodyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (padding * 2)),
//            bodyLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: padding)
            bodyLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureRightLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(padding * 2)),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: bodyLabel.trailingAnchor, constant: padding),
            bodyLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}
