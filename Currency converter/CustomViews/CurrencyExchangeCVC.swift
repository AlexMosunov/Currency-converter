//
//  CurrencyExchangeTVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 15.10.2021.
//

import UIKit

class CurrencyExchangeCVC: UICollectionViewCell {
    
    static let reuseID = "CurrencyExchangeCVC"
    let titleLabel = CETitleLabel(textAlignment: .right, fontSize: 16)
    let bodyLabel = CEBodyLabel(textAlignment: .left)
    let emogyFlagLabel = CETitleLabel(textAlignment: .center, fontSize: 28)
    let rateLabel = CETitleLabel(textAlignment: .center, fontSize: 20)
    let stackView = UIStackView()
    
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureEmoji()
        configureStackView()
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
        print(currencyFlag)
        let rateCross = currencyPair.rateCross
        let rateBuy = currencyPair.rateBuy
        let rateSell = currencyPair.rateSell
        
        
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
        
        
        
        
//        for pair in currencyPairs {
//            print("-----------------")
//            let curr = pair.currencyCodeA
//            let curCode = self.getCurrencyCodeName(curr)
//            print(curCode)
//            print(self.getCurrencyCodeName(pair.currencyCodeB))
//            print(curr)
//            print(self.getCurrencyFullName(code: curCode ?? ""))
////                let countryname = self.getCurrencyFullName(code: curCode ?? "")
//            print("Country name - \(String(curr ?? 0).toCountryName)")
//            let locale = Locale(identifier: "en_US_POSIX")
////                print(locale.isoCode(for: "ALGERIA"))
//            print("Country code - \(locale.isoCode(for: String(curr ?? 0).toCountryName))")
//            print("Country flag - \(self.getFlag(from: locale.isoCode(for: String(curr ?? 0).toCountryName) ?? ""))")
//            print(Date(timeIntervalSince1970: TimeInterval(pair.date ?? 0)) )
//            print(pair.rateCross ?? 0)
//            print(pair.rateBuy ?? 0)
//            print(pair.rateSell ?? 0)
//            print("-----------------")
//        }
    }
    
    
    private func configureEmoji() {
        self.backgroundColor = .cyan
        
        addSubview(emogyFlagLabel)
        
        
        NSLayoutConstraint.activate([
            emogyFlagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            emogyFlagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
            emogyFlagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding * 2),
            emogyFlagLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    private func configureRate() {
        addSubview(rateLabel)
        NSLayoutConstraint.activate([
        rateLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
        rateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
        rateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding * 2),
        rateLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.axis         = .horizontal
        stackView.distribution = .fill
        stackView.spacing      = 10

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: emogyFlagLabel.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding * 2),
            stackView.heightAnchor.constraint(equalToConstant: 35),
            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width)
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
