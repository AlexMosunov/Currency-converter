//
//  ConverterModel.swift
//  Currency converter
//
//  Created by Alex Mosunov on 10.09.2021.
//

import Foundation

class ConverterModel {
    
    var currencyPairsDictionary = [CurrencyPairs:Float]()
    
    static let shared = ConverterModel()
    
    private init() { }
    
    func calcData(_ data: [CurrencyPairPrivatbank]) {
        for item in data {
            if item.base_ccy == "UAH" {
                switch item.ccy {
                case "USD":
                    if let sale = item.sale, let mult = Float(sale) {
                        let m = 1 / mult
                        currencyPairsDictionary[.UAHtoUSD] = m
                    }
                    if let buy = item.buy, let mult = Float(buy) {
                        let m = mult
                        currencyPairsDictionary[.USDtoUAH] = m
                    }
                case "EUR":
                    if let sale = item.sale, let mult = Float(sale) {
                        let m = 1 / mult
                        currencyPairsDictionary[.UAHtoEUR] = m
                    }
                    
                    if let buy = item.buy, let mult = Float(buy) {
                        let m = mult
                        currencyPairsDictionary[.EURtoUAH] = m
                    }
                case "RUR":
                    if let sale = item.sale, let mult = Float(sale) {
                        let m = 1 / mult
                        currencyPairsDictionary[.UAHtoRUR] = m
                    }
                    
                    if let buy = item.buy, let mult = Float(buy) {
                        let m = mult
                        currencyPairsDictionary[.RURtoUAH] = m
                    }
                default:
                    break
                }
            }
//            else if item.base_ccy == "USD" {
//                switch item.ccy {
//                case "UAH":
//                    if let buy = item.buy, let mult = Float(buy) {
//                        let m = mult
//                        currencyPairsDictionary[.USDtoUAH] = m
//                    }
//                case "EUR":
//                    if let buy = item.buy, let mult = Float(buy) {
//                        let m = 1 / mult
//                        currencyPairsDictionary[.USDtoEUR] = m
//                    }
//                case "RUR":
//                    if let buy = item.buy, let mult = Float(buy) {
//                        let m = 1 / mult
//                        currencyPairsDictionary[.USDtoRUR] = m
//                    }
//                default:
//                    break
//                }
//            }
        }
    }
    
    
    
    
    func getCurrencyCourse(baseCurrency: Currency, currency: Currency) -> Float? {
        switch baseCurrency {
        case .uah:
            switch currency {
            case .uah:
                return 1
            case .usd:
                return currencyPairsDictionary[.UAHtoUSD]
            case .eur:
                return currencyPairsDictionary[.UAHtoEUR]
            case .rur:
                return currencyPairsDictionary[.UAHtoRUR]
            }
        case .usd:
            switch currency {
            case .uah:
                return currencyPairsDictionary[.USDtoUAH]
            case .usd:
                return 1
            case .eur:
                return currencyPairsDictionary[.USDtoEUR]
            case .rur:
                return currencyPairsDictionary[.USDtoRUR]
            }
        case .eur:
            switch currency {
            case .uah:
                return currencyPairsDictionary[.EURtoUAH]
            case .usd:
                return currencyPairsDictionary[.EURtoUSD]
            case .eur:
                return 1
            case .rur:
                return currencyPairsDictionary[.EURtoRUR]
            }
        case .rur:
            switch currency {
            case .uah:
                return currencyPairsDictionary[.RURtoUAH]
            case .usd:
                return currencyPairsDictionary[.RURtoUSD]
            case .eur:
                return currencyPairsDictionary[.RURtoEUR]
            case .rur:
                return 1
            }
            
            
            
        default:
            return nil
        }
    }
    
//    func getCurrencyCourse() -> Float? {
//        switch currencyPair
//        {
//        case .UAHtoUSD:
//            return USDtoUAH
//        default:
//            return nil
//        }
//    }
    
    
    
    
}


public enum CurrencyPairs: Float {
    case UAHtoUSD
    case USDtoUAH
    
    case UAHtoEUR
    case EURtoUAH
    
    case UAHtoRUR
    case RURtoUAH
    
    case USDtoEUR
    case EURtoUSD
    
    case USDtoRUR
    case RURtoUSD
    
    case EURtoRUR
    case RURtoEUR
    
    case equalCurrencies
}
