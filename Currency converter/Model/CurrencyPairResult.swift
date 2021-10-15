//
//  CurrencyPairResult.swift
//  Currency converter
//
//  Created by Alex Mosunov on 10.09.2021.
//

import Foundation

enum Currency: String, CaseIterable {
    case usd = "USD"
    case eur = "EUR"
    case rur = "RUR"
    case uah = "UAH"
    
    static func getCurrency(_ currency: String) -> Currency? {
        switch currency {
        case Currency.usd.rawValue:
            return .usd
        case Currency.uah.rawValue:
            return .uah
        case Currency.eur.rawValue:
            return .eur
        case Currency.rur.rawValue:
            return .rur
        default:
            return nil
        }
    }
    
    static var allCasesStringsArray: [String] {
        var array = [String]()
        for currency in allCases {
            array.append(currency.rawValue)
        }
        return array
    }
}


struct CurrencyPairResult {
    let pair: CurrencyPairs
    let multiplier: Float?
}
