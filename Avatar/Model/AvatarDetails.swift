//
//  AvatarDetails.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import Foundation

struct Details: Codable {
    var title, year, rated, released: String
    var runtime, genre, director, writer: String
    var actors, plot, language, country: String
    var awards: String
    var poster: String
    var ratings: [Rating]
    var metascore, imdbRating, imdbVotes, imdbID: String
    var type, dvd, boxOffice, production: String
    var website, response: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }

    var description: CustomStringConvertible {
        return "Title: \(title) \n\nYear: \(year) \n\nRated: \(rated) \n\n" + "Released: \(released) \n\n" + "Runtime: \(runtime) \n\n" + "Genre: \(genre) \n\n" + "Director: \(director) \n\n" + "Writer: \(writer) \n\n" + "Actors: \(actors) \n\n" + "Plot: \(plot) \n\n" + "Language: \(language) \n\n" + "Country: \(country) \n\n" + "Awards: \(awards) \n\n" + "Ratings: \(ratings.description) \n\n" + "Metascore: \(metascore) \n\n" + "ImdbRating: \(imdbRating) \n\n" + "ImdbVotes: \(imdbVotes) \n\n" + "ImdbID: \(imdbID) \n\n" + "Type: \(type) \n\n" + "DVD: \(dvd) \n\n" + "BoxOffice: \(boxOffice) \n\n" + "Production: \(production) \n\n" + "Website: \(website) \n\n"  + "Response: \(response)"
    }
}

struct Rating: Codable {
    var source, value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }

    var description: CustomStringConvertible {
        return "\(source): \(value)"
    }
}
