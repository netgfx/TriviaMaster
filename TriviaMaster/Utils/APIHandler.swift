//
//  ApiHandler.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 28/12/20.
//

import Foundation
import Alamofire
import Combine

class APIHandler {
        
    var response_code = Int.zero
    
    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            print(response.value, response.data)
            return response.value
        case .failure:
            return nil
        }
    }
}
