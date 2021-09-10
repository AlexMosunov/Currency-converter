//
//  String+Ext.swift
//  Currency converter
//
//  Created by Alex Mosunov on 09.09.2021.
//

import Foundation
extension String {
    
    public var toCurrencyCode: String {
        if let path = Bundle.main.path(forResource: "isoCodes", ofType: "plist") {
            for item in NSArray(contentsOfFile: path) ?? [] {
                if let value = item as? NSDictionary {
                    if value["digitsCode"] as? String == self {
                        return value["currencyCode"] as? String ?? "-"
                    }
                }
            }
        }
        return "-"
    }
}
