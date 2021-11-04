//
//  UserTransaction.swift
//  Currency converter
//
//  Created by Alex Mosunov on 31.10.2021.
//

import Foundation


class UserTransaction: Decodable {
    let amount: Int64?
    let mcc: Int32?
    
    init?(json: [String: Any]) {
        let amount = json["amount"] as? Int64
        let mcc = json["mcc"] as? Int32

        self.amount = amount
        self.mcc = mcc
    }
    
    static func getArray(from jsonArray: Any) -> [UserTransaction]? {
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        return jsonArray.compactMap { UserTransaction(json: $0) }
    }
}
