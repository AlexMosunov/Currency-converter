//
//  AlamofireNetworkRequest.swift
//  Currency converter
//
//  Created by Alex Mosunov on 09.09.2021.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [CurrencyPairPrivatbank])->()) {
        
        guard let url = URL(string: url) else { return }
        
        
        request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                print(value)
                
                var currencyPairs = [CurrencyPairPrivatbank]()
                currencyPairs = CurrencyPairPrivatbank.getArray(from: value)!
                completion(currencyPairs)
//                var courses = [Course]()
//                courses = Course.getArray(from: value)!
//                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
