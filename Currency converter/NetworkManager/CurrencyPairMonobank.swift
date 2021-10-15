//
//  CurrencyPair.swift
//  Currency converter
//
//  Created by Alex Mosunov on 09.09.2021.
//

import Foundation

struct CurrencyPairMonobank: CurrencyPair, Hashable {
    
    let currencyCodeA: Int?
    let currencyCodeB: Int?
    let date: Int?
    let rateBuy: Double?
    let rateSell: Double?
    let rateCross: Double?
    
    init?(json: [String: Any]) {
        
        let currencyCodeA = json["currencyCodeA"] as? Int
        let currencyCodeB = json["currencyCodeB"] as? Int

        let date = json["date"] as? Int
        
        let rateBuy = json["rateBuy"] as? Double
        let rateSell = json["rateSell"] as? Double
        let rateCross = json["rateCross"] as? Double
        
        self.currencyCodeA = currencyCodeA
        self.currencyCodeB = currencyCodeB
        self.date = date
        self.rateBuy = rateBuy
        self.rateSell = rateSell
        self.rateCross = rateCross
    }
    
    static func getArray(from jsonArray: Any) -> [CurrencyPairMonobank]? {
        
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        return jsonArray.compactMap { CurrencyPairMonobank(json: $0) }
        
    }
}
