//
//  MovieDetailsViewModel.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import SwiftUI
import SwiftyJSON

class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetailsModel? = nil
    
    func fetchMovieDetails(movieID: String? = nil) {
        guard movieID != nil else {
            return
        }
        if let movieID = movieID {
            RestClient().callApi(api: movieID + "?", completion: { (result) in
                switch result {
                case.success(let response):
                    let json = JSON(response)
                    self.movieDetails = MovieDetailsModel(json: json)
                case .failure(let error) :
                    print("Error: \(error.localizedDescription)")
                }
            }, type: .GET, data: nil, isAbsoluteURL: false, headers: nil, isSilent: false, jsonSerialize: false)
        } else {
            
        }
    }
}
