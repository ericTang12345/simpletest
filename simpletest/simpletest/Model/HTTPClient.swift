//
//  HTTPClient.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/21.
//

import Foundation

enum Result<T> {
    
    case success(T)
    
    case failure(Error)
}

enum API {
    
    var url: String {
       
        return "https://blooming-oasis-01056.herokuapp.com/"
    }
    
    case category
    
    case sale(Int)
    
    case product(Int)
    
    func makeFullUrl() -> URL {
        
        switch self {
        
        case .category:
            
            return URL(string: url + "category")!
        
        case .sale(let id):
            
            return URL(string: url + "sale?id=\(id)")!
            
        case .product(let id):
            
            return URL(string: url + "product?id=\(id)")!
        }
    }
}

enum HTTPClientError: Error {

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

class HTTPClient {
    
    func request(api: API, completion: @escaping (Result<Data>) -> Void) {
        
        URLSession.shared.dataTask(with: api.makeFullUrl()) { (data, respones, error) in
            
            if error != nil {
        
                return completion(.failure(error!))
            }
            
            let httpRespnse = respones as! HTTPURLResponse
            
            switch httpRespnse.statusCode {
            
            case 200 ..< 300:
                
                completion(.success(data!))
            
            case 400 ..< 500:
                
                completion(.failure(HTTPClientError.clientError(data!)))
                
            case 500 ..< 600:
                
                completion(.failure(HTTPClientError.serverError))
                
            default: return
                
                completion(.failure(HTTPClientError.unexpectedError))
            }
            
        }.resume()
    }
    
}
