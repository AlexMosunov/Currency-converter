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
    let bodyLabel = CEBodyLabel(textAlignment: .left)
    let emogyFlagLabel = CETitleLabel(textAlignment: .center, fontSize: 20)
    let rateLabel = CETitleLabel(textAlignment: .left, fontSize: 20)
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureEmoji()
        configureStackView()
        configureBodyLabel()
        configureRate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(currencyPair: CurrencyPairMonobank) {
        
        let currencyCodeA = Utils.tuneCurrencyCode(currencyPair.currencyCodeA)
        let currencyCodeB = Utils.tuneCurrencyCode(currencyPair.currencyCodeB)
        let currencyCodeNameA = currencyCodeA?.toCurrencyCode
        let currencyCodeNameB = currencyCodeB?.toCurrencyCode
        let currencyName = Utils.getCurrencyFullName(code: currencyCodeNameA ?? "") ?? ""
        
        let locale = Locale(identifier: "en_US_POSIX")
        let coutryName = currencyCodeA?.toCountryName ?? ""
        let countryCode = locale.isoCode(for: coutryName) ?? ""
        let currencyFlag = Utils.getFlag(from: countryCode)

        let rateCross = currencyPair.rateCross
        let rateBuy = currencyPair.rateBuy
        let rateSell = currencyPair.rateSell
        print("---------------------------------")
        print("currencyCodeA - \(currencyCodeA)")
        print("currencyCodeA - \(currencyCodeB)")
        print("currencyName - \(currencyName)")
        print("coutryName - \(coutryName)")
        print("countryCode - \(countryCode)")
        print("currencyFlag - \(currencyFlag)")
        
        if currencyCodeNameB == "UAH" {
            titleLabel.text = currencyCodeNameA
            bodyLabel.text = currencyName
            emogyFlagLabel.text = currencyFlag
            if rateCross != nil {
                rateLabel.text = String(rateCross!)
            } else if rateSell != nil {
                rateLabel.text = String(rateSell!)
            } else if rateBuy != nil {
                rateLabel.text = String(rateBuy!)
            } else {
                rateLabel.text = ""
            }
        }
        if currencyFlag.isEmpty {
            stackView.removeArrangedSubview(emogyFlagLabel)
        }
    }
    
    
    private func configureBodyLabel() {
        self.backgroundColor = .cyan
        
        addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(padding * 2)),
            bodyLabel.heightAnchor.constraint(equalToConstant: 22),
            bodyLabel.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width * 0.9)
            
        ])
    }
    
    private func configureRate() {
        addSubview(rateLabel)
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: padding),
            rateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
            rateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(padding * 2)),
            rateLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(emogyFlagLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.axis         = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing      = 10
        stackView.alignment    = .leading

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
//            stackView.widthAnchor.constraint(equalToConstant: emogyFlagLabel.frame.width + titleLabel.frame.width + 10),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(padding * 2)),
            stackView.heightAnchor.constraint(equalToConstant: 35)
//            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width)
        ])
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
