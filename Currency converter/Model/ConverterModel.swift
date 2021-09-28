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
        var UAHtoUSD: Float?
        var USDtoUAH: Float?
        var UAHtoEUR: Float?
        var EURtoUAH: Float?
        var UAHtoRUR: Float?
        var RURtoUAH: Float?
    
        for item in data {
            if item.base_ccy == "UAH" {
                switch item.ccy {
                case "USD":
                    if let sale = item.sale, let mult = Float(sale) {
                        let mult = 1 / mult
                        currencyPairsDictionary[.UAHtoUSD] = mult
                        UAHtoUSD = mult
                    }
                    if let buy = item.buy, let mult = Float(buy) {
                        let mult = mult
                        currencyPairsDictionary[.USDtoUAH] = mult
                        USDtoUAH = mult
                    }
                case "EUR":
                    if let sale = item.sale, let mult = Float(sale) {
                        let mult = 1 / mult
                        currencyPairsDictionary[.UAHtoEUR] = mult
                        UAHtoEUR = mult
                    }
                    
                    if let buy = item.buy, let mult = Float(buy) {
                        let mult = mult
                        currencyPairsDictionary[.EURtoUAH] = mult
                        EURtoUAH = mult
                    }
                case "RUR":
                    if let sale = item.sale, let mult = Float(sale) {
                        let mult = 1 / mult
                        currencyPairsDictionary[.UAHtoRUR] = mult
                        UAHtoRUR = mult
                    }
                    
                    if let buy = item.buy, let mult = Float(buy) {
                        let mult = mult
                        currencyPairsDictionary[.RURtoUAH] = mult
                        RURtoUAH = mult
                    }
                default:
                    break
                }
            }
        }
        
        guard UAHtoUSD != nil,
              UAHtoEUR != nil,
              UAHtoRUR != nil,
              RURtoUAH != nil,
              EURtoUAH != nil,
              USDtoUAH != nil else { return }
        currencyPairsDictionary[.USDtoEUR] = UAHtoEUR! / UAHtoUSD!
        currencyPairsDictionary[.EURtoUSD] = EURtoUAH! / USDtoUAH!
        
        currencyPairsDictionary[.USDtoRUR] = UAHtoRUR! / UAHtoUSD!
        currencyPairsDictionary[.RURtoUSD] = RURtoUAH! / USDtoUAH!
        
        currencyPairsDictionary[.EURtoRUR] = UAHtoRUR! / UAHtoEUR!
        currencyPairsDictionary[.RURtoEUR] = RURtoUAH! / EURtoUAH!
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
        }
    }
    
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
    
}
