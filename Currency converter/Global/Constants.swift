//
//  Constants.swift
//  Currency converter
//
//  Created by Alex Mosunov on 28.09.2021.
//

import Foundation


struct Constants {
    
    struct Mono {
        static let baseUrlMonoString = "https://api.monobank.ua/bank"
        static let getCurrencies = "/currency"
    }
    
    
    struct PrivatBank {
        static let baseUrlPBString = "https://api.privatbank.ua/p24api"
        static let getBaseCurrencyExchanges = "/pubinfo?json&exchange&coursid=5"
        static let baseCurrencies = baseUrlPBString + getBaseCurrencyExchanges
    }

    
}
