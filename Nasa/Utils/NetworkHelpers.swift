//
//  NetworkHelpers.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import Alamofire
import AlamofireURLCache5

public enum ApiResult<Value> {
    case success(Value)
    case failure(Error)
    case timeOutFailure(String)
}

public enum Error: Swift.Error {
    case serializationError(internal: Swift.Error)
    case timeRequestError(String)
    case networkError(internal: Swift.Error)
}

protocol NetworkServiceProtocol {
    func getAllData(complation: @escaping (ApiResult<InfinityModel>) -> Void) // n tpinde alınması sağlanabilir.
}
 
public struct NetworkHelper: NetworkServiceProtocol {
    func getAllData(complation: @escaping (ApiResult<InfinityModel>) -> Void) {
        
        AF.request(Constant.API_URL+Constant.API_KEY+Constant.API_PAGINATION,refreshCache:false).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                do {
        
                    if let jsonDecode = try JSONDecoder().decode(InfinityModel?.self, from: response.data ?? Data.init())
                    {
                        complation(.success(jsonDecode))
                    }
                } catch let error {
                    complation(.failure(.serializationError(internal: error)))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    complation(.timeOutFailure("Timeout request!"))
                default:
                    print("Other error!")
                }
            }
            
        },autoClearCache:false).cache(maxAge: 10)
    }
    
}
