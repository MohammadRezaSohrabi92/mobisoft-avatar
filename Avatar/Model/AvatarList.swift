//
//  AvatarList.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import Foundation

struct AvatarList: Codable {
    var search: [Search]
    var totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct Search: Codable {
    var title, year, imdbID: String
    var type: TypeEnum
    var poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case game = "game"
    case movie = "movie"
    case series = "series"
}
