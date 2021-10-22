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
    
    static func sendRequest(url: String, apiType: apiTypes, completion: @escaping (_ result: Result<[CurrencyPair], Error>)->()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                switch apiType {
                case .monoBank:
                    var currencyPairsMono = [CurrencyPairMonobank]()
                    currencyPairsMono = CurrencyPairMonobank.getArray(from: value)!
                    completion(.success(currencyPairsMono))
                case .privatBank:
                    var currencyPairsPrivat = [CurrencyPairPrivatbank]()
                    currencyPairsPrivat = CurrencyPairPrivatbank.getArray(from: value)!
                    completion(.success(currencyPairsPrivat))
                }
                
            case .failure(let error):
                print("Error- \(error)")
                completion(.failure(error))
            }
        }
        
    }
    
    static func getUserInfo(url: String) {
        AF.request(url, method: .get,  headers: [HTTPHeader(name: "X-Token", value: "")] ).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                print("!!! USER DATA - \(value)")
                
            case .failure(let error):
                print("error = \(error)")
            }
            
        }
    }
        
        static func getTransactions(url: String) {
            AF.request(url, method: .get, headers: [HTTPHeader(name: "X-Token", value: "")]).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                print("!!! USER TRANSACTIONS - \(value)")
                
            case .failure(let error):
                print("error = \(error)")
            }
            
        
        }
    }
    
    static func sendRequest<T : Decodable>(url: String, completion: @escaping (Result<[T], Error>) -> Void) throws -> T {
        AF.request(url).responseDecodable(of: [T].self) { response in
            guard let acronyms = response.value else {
                return
            }
            completion(.success(acronyms))
        } as! T
    }
    
}
