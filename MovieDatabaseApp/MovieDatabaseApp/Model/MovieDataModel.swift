//
//  MovieDataModel.swift
//  MovieDatabaseApp
//
//  Created by Kishore B on 8/20/24.
//

import Foundation

struct Movie: Codable {
        let titleStr, year, rated, released: String
        let runtime, genre, director, writer: String
        let actors, plot, language, country: String
        let awards: String
        let poster: String
        let ratings: [Rating]
        let metascore, imdbRating, imdbVotes, imdbID: String

        enum CodingKeys: String, CodingKey {
            case titleStr = "Title"
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
        }
    }

    // MARK: - Rating
    struct Rating: Codable {
        let source, value: String

        enum CodingKeys: String, CodingKey {
            case source = "Source"
            case value = "Value"
        }
    }

func parseMoviesData() -> [Movie]? {
    if let url = Bundle.main.url(forResource: "movies", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let moviesData = try JSONDecoder().decode([Movie].self, from: data)
            return moviesData
        } catch {
            print("Failed to parse JSON:", error)
            return nil
        }
    }
    return nil
}

