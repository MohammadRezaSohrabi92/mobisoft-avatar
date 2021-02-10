//
//  BaseSDK.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import Foundation

class BaseSDK {

    let baseURLstring = "http://omdbapi.com"

    let decoder = JSONDecoder()

    func makeURL(url: String) -> URL {
        return URL(string: baseURLstring + url)!
    }
}
