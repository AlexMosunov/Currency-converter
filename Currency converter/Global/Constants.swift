//
//  Constants.swift
//  Currency converter
//
//  Created by Alex Mosunov on 28.09.2021.
//

import Foundation


struct Constants {
    
    struct Mono {
        static let baseUrlMonoString = "https://api.monobank.ua"
        static let allCurrencies = "/bank/currency"
        static let personalInfo = "/personal/client-info"
        static let transactionsInfo = "/personal/statement/0/1633088970"
        static let getAllCurrencyExchanges = baseUrlMonoString + allCurrencies
        static let getPersonalInfo = baseUrlMonoString + personalInfo
        static let getUserTransactions = baseUrlMonoString + transactionsInfo
    }
    
    
    struct PrivatBank {
        static let baseUrlPBString = "https://api.privatbank.ua/p24api"
        static let baseCurrencies = "/pubinfo?json&exchange&coursid=5"
        static let getBaseCurrencyExchanges = baseUrlPBString + baseCurrencies
    }

    
}
