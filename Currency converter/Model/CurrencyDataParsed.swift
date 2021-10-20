//
//  CurrencyDataParsed.swift
//  Currency converter
//
//  Created by Alex Mosunov on 19.10.2021.
//

import Foundation

struct CurrencyDataParsed: Hashable {
    var currencyCodeA    : String?
    var currencyCodeB    : String?
    var currencyCodeNameA: String?
    var currencyCodeNameB: String?
    var currencyNameA    : String?
    var coutryName       : String?
    var countryCodeA     : String?
    var currencyFlagA    : String
    var rateCross        : Double?
    var rateBuy          : Double?
    var rateSell         : Double?
}
