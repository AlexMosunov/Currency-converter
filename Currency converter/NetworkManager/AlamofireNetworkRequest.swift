//
//  AlamofireNetworkRequest.swift
//  Currency converter
//
//  Created by Alex Mosunov on 09.09.2021.
//

import Foundation
import Alamofire

enum apiTypes: Int {
    case monoBank
    case privatBank
}

class AlamofireNetworkRequest {
    
    
    static func sendRequest(url: String, apiType: apiTypes, completion: @escaping (_ courses: [CurrencyPair])->()) {
        
        guard let url = URL(string: url) else { return }
        
        request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                switch apiType {
                case .monoBank:
                    var currencyPairsMono = [CurrencyPairMonobank]()
                    currencyPairsMono = CurrencyPairMonobank.getArray(from: value)!
                    completion(currencyPairsMono)
                case .privatBank:
                    var currencyPairsPrivat = [CurrencyPairPrivatbank]()
                    currencyPairsPrivat = CurrencyPairPrivatbank.getArray(from: value)!
                    completion(currencyPairsPrivat)
                }
                
            case .failure(let error):
                print("Error- \(error)")
            }
        }
    }
    
}
