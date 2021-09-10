//
//  CurrencyPairResult.swift
//  Currency converter
//
//  Created by Alex Mosunov on 10.09.2021.
//

import Foundation

enum Currency: String {
    case usd = "USD"
    case uah = "UAH"
    case eur = "EUR"
    case rur = "RUR"
    
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
}


struct CurrencyPairResult {
    
    let pair: CurrencyPairs
    let multiplier: Float?
}
