//
//  CurrencyExchangeTVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 15.10.2021.
//

import UIKit

class CurrencyExchangeCVC: UICollectionViewCell {
    
    static let reuseID = "CurrencyExchangeCVC"
    let padding: CGFloat = 4
    
    let titleLabel = CETitleLabel(textAlignment: .center, fontSize: 16)
    let bodyLabel = CEBodyLabel(textAlignment: .center)
    let emogyFlagLabel = CETitleLabel(textAlignment: .center, fontSize: 20)
    let rateLabel = CETitleLabel(textAlignment: .center, fontSize: 20)
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemTeal
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        configureStackView()
        configureBodyLabel()
        configureRate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(currencyPair: CurrencyDataParsed) {
        titleLabel.text = currencyPair.currencyCodeNameA
        bodyLabel.text = currencyPair.currencyNameA
        emogyFlagLabel.text = currencyPair.currencyFlagA
        if currencyPair.rateCross != nil {
            rateLabel.text = String(currencyPair.rateCross!)
        } else if currencyPair.rateSell != nil {
            rateLabel.text = String(currencyPair.rateSell!)
        } else if currencyPair.rateBuy != nil {
            rateLabel.text = String(currencyPair.rateBuy!)
        } else {
            rateLabel.text = ""
        }
        
    }
    
    
    private func configureBodyLabel() {
        addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 2),
            bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(padding * 2)),
            bodyLabel.widthAnchor.constraint(lessThanOrEqualToConstant: self.frame.width),
            bodyLabel.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    
    private func configureRate() {
        addSubview(rateLabel)
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: padding),
            rateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 2),
            rateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(padding * 2)),
            rateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(emogyFlagLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.axis         = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing      = 0
        stackView.alignment    = .center
//        stackView.center = self.center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
//            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 2),
//            stackView.widthAnchor.constraint(equalToConstant: 50),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(padding * 2)),
            stackView.heightAnchor.constraint(equalToConstant: 30),
            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: self.frame.width)
        ])
    }
    

}
