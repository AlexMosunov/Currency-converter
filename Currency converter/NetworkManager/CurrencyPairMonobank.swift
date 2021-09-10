//
//  CurrencyPair.swift
//  Currency converter
//
//  Created by Alex Mosunov on 09.09.2021.
//

import Foundation

struct CurrencyPairMonobank {
    
    let currencyCodeA: Int?
    let currencyCodeB: Int?
    let date: Int?
    let rateBuy: Float?
    let rateSell: Float?
    let rateCross: Float?
    
    init?(json: [String: Any]) {
        
        let currencyCodeA = json["currencyCodeA"] as? Int
        let currencyCodeB = json["currencyCodeB"] as? Int

        let date = json["date"] as? Int
        
        let rateBuy = json["rateBuy"] as? Float
        let rateSell = json["rateSell"] as? Float
        let rateCross = json["rateCross"] as? Float
        
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
