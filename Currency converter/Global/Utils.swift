//
//  Utils.swift
//  Currency converter
//
//  Created by Alex Mosunov on 15.10.2021.
//

import Foundation

struct Utils {
    
    static func getCurrencyFullName(code: String) -> String? {
        return Locale.current.localizedString(forCurrencyCode: code)
    }
    
    static func tuneCurrencyCode(_ currencyCode: Int?) -> String? {
        guard let currencyCode = currencyCode else { return nil}
        var curr = String(currencyCode)
        if curr.count == 2 {
            curr = "0" + curr
        } else if curr.count == 1 {
            curr = "00" + curr
        }
        return curr
    }
    
//    static func getCurrencyCodeName(_ currencyCode: Int?) -> String? {
//        guard let currencyCode = currencyCode else { return nil}
//        let currencyCodeName = tuneCurrencyCode(currencyCode)
//        let curCode = curr.toCurrencyCode
//        return curCode
//    }
    
    static func getFlag(from countryCode: String) -> String {
        countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
}
