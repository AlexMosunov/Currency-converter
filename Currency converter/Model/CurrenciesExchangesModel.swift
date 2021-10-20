//
//  CurrenciesExchangesModel.swift
//  Currency converter
//
//  Created by Alex Mosunov on 19.10.2021.
//

import Foundation

class CurrenciesExchangesModel {
    
    static let shared = CurrenciesExchangesModel()
    
    private init() { }
    
    func parseCurrencyExchangePairs(from currencyPairs: [CurrencyPairMonobank]) -> [CurrencyDataParsed] {
        let locale = Locale(identifier: "en_US_POSIX")
        var currencyDataParsedArray: [CurrencyDataParsed] = []
        for currencyPair in currencyPairs {
            let currencyCodeA = Utils.tuneCurrencyCode(currencyPair.currencyCodeA)
            let currencyCodeB = Utils.tuneCurrencyCode(currencyPair.currencyCodeB)
            let currencyCodeNameA = currencyCodeA?.toCurrencyCode
            let currencyCodeNameB = currencyCodeB?.toCurrencyCode
            let currencyName = Utils.getCurrencyFullName(code: currencyCodeNameA ?? "") ?? ""
            
            let coutryName = currencyCodeA?.toCountryName ?? ""
            let countryCode = locale.isoCode(for: coutryName) ?? ""
            let currencyFlag = Utils.getFlag(from: countryCode)
            
            let rateCross = currencyPair.rateCross
            let rateBuy = currencyPair.rateBuy
            let rateSell = currencyPair.rateSell
            
            let currencyDataParsed = CurrencyDataParsed(currencyCodeA: currencyCodeA,
                                                        currencyCodeB: currencyCodeB,
                                                        currencyCodeNameA: currencyCodeNameA,
                                                        currencyCodeNameB: currencyCodeNameB,
                                                        currencyNameA: currencyName,
                                                        countryCodeA: countryCode,
                                                        currencyFlagA: currencyFlag,
                                                        rateCross: rateCross,
                                                        rateBuy: rateBuy,
                                                        rateSell: rateSell)
            
            
            currencyDataParsedArray.append(currencyDataParsed)
            
        }
        
        return currencyDataParsedArray
        
    }
    
    func filterCurrencies(array: [CurrencyPairMonobank], code: Int) -> [CurrencyPairMonobank] {
        array.filter { $0.currencyCodeB == code }
    }
    
}
