//
//  CurrencyPairPrivatbank.swift
//  Currency converter
//
//  Created by Alex Mosunov on 09.09.2021.
//

import Foundation

struct CurrencyPairPrivatbank {
    
    let ccy: String?
    let base_ccy: String?
    let buy: String?
    let sale: String?

    
    init?(json: [String: Any]) {
        let ccy = json["ccy"] as? String
        let base_ccy = json["base_ccy"] as? String
        let buy = json["buy"] as? String
        let sale = json["sale"] as? String

        self.ccy = ccy
        self.base_ccy = base_ccy
        self.buy = buy
        self.sale = sale
    }
    
    static func getArray(from jsonArray: Any) -> [CurrencyPairPrivatbank]? {
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        return jsonArray.compactMap { CurrencyPairPrivatbank(json: $0) }
    }
}
