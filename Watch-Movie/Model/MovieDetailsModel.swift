//
//  MovieDetailsModel.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import SwiftyJSON

struct MovieDetailsModel {
    let budget: Int
    let releaseDate: String
    let homepage: String
    let voteAverage: Double
    let productionCountries: [ProductionCountry]
    let productionCompanies: [ProductionCompany]
    let status: String
    let id: Int
    let revenue: Int
    let backdropPath: String?
    let runtime: Int
    let popularity: Double
    let originalLanguage: String
    let imdbId: String
    let adult: Bool
    let posterPath: String
    let genres: [Genre]
    let video: Bool
    let voteCount: Int
    let title: String
    let overview: String
    let tagline: String
    let spokenLanguages: [SpokenLanguage]
    let originalTitle: String
    
    init(json: JSON) {
        budget = json["budget"].intValue
        releaseDate = json["release_date"].stringValue
        homepage = json["homepage"].stringValue
        voteAverage = json["vote_average"].doubleValue
        productionCountries = json["production_countries"].arrayValue.map { ProductionCountry(json: $0) }
        productionCompanies = json["production_companies"].arrayValue.map { ProductionCompany(json: $0) }
        status = json["status"].stringValue
        id = json["id"].intValue
        revenue = json["revenue"].intValue
        backdropPath = json["backdrop_path"].string
        runtime = json["runtime"].intValue
        popularity = json["popularity"].doubleValue
        originalLanguage = json["original_language"].stringValue
        imdbId = json["imdb_id"].stringValue
        adult = json["adult"].boolValue
        posterPath = json["poster_path"].stringValue
        genres = json["genres"].arrayValue.map { Genre(json: $0) }
        video = json["video"].boolValue
        voteCount = json["vote_count"].intValue
        title = json["title"].stringValue
        overview = json["overview"].stringValue
        tagline = json["tagline"].stringValue
        spokenLanguages = json["spoken_languages"].arrayValue.map { SpokenLanguage(json: $0) }
        originalTitle = json["original_title"].stringValue
    }
}

struct ProductionCountry {
    let name: String
    let iso31661: String
    
    init(json: JSON) {
        name = json["name"].stringValue
        iso31661 = json["iso_3166_1"].stringValue
    }
}

struct ProductionCompany {
    let originCountry: String
    let logoPath: String?
    let id: Int
    let name: String
    
    init(json: JSON) {
        originCountry = json["origin_country"].stringValue
        logoPath = json["logo_path"].string
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}

struct Genre {
    let name: String
    let id: Int
    
    init(json: JSON) {
        name = json["name"].stringValue
        id = json["id"].intValue
    }
}

struct Collection {
    let name: String
    let id: Int
    let posterPath: String?
    let backdropPath: String?
    
    init(json: JSON) {
        name = json["name"].stringValue
        id = json["id"].intValue
        posterPath = json["poster_path"].string
        backdropPath = json["backdrop_path"].string
    }
}

struct SpokenLanguage {
    let iso6391: String
    let name: String
    let englishName: String
    
    init(json: JSON) {
        iso6391 = json["iso_639_1"].stringValue
        name = json["name"].stringValue
        englishName = json["english_name"].stringValue
    }
}
