//
//  Locale+Ext.swift
//  Currency converter
//
//  Created by Alex Mosunov on 15.10.2021.
//

import Foundation

extension Locale {
    func isoCode(for countryName: String) -> String? {
        return Locale.isoRegionCodes.first(where: { (code) -> Bool in
            localizedString(forRegionCode: code)?.compare(countryName, options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame
        })
    }
}
