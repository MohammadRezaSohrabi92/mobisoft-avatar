//
//  NetworkingClient.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import Foundation
import Alamofire

class NetworkingClient {

    static let shared : NetworkingClient = {
        let instance = NetworkingClient()
        return instance
    }()

    typealias webserviceResponse = (Data?, Error?) -> Void

    func executeGETrequest(_ url: URLConvertible, completion: @escaping webserviceResponse) {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).validate().responseData { (response) in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
            if let error = response.error {
                completion(nil, error)
            } else if let data = response.data {
                completion(data, nil)
            }
        }
    }
}
