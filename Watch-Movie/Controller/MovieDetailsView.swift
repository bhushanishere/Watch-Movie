//
//  DetailsView.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import SwiftUI

struct MovieDetailsView: View {

    @ObservedObject var viewModel: MovieDetailsViewModel
    let movieID: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                if let details = viewModel.movieDetails {
                    AsyncImage(url: URL(string: kImageURL + details.posterPath)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .frame(height: 510)
                            .cornerRadius(15)
                            .clipped()
                            .shadow(radius: 20)
                    } placeholder: {
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text(details.title)
                            .font(.title)
                            .fontWeight(.bold)
                        HStack(alignment:.center, spacing: 8 ) {
                            Text("Genres: ")
                                .font(.body)
                                .foregroundColor(.black)
                            Text(details.genres.map { $0.name }.joined(separator: ", "))
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        HStack(alignment:.center, spacing: 8 ) {
                            Text("Release Date: ")
                                .font(.body)
                                .foregroundColor(.black)
                            Text(String( details.releaseDate))
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        HStack(alignment:.center, spacing: 8 ) {
                            Text("Vote: ")
                                .font(.body)
                                .foregroundColor(.black)
                            Text(String(details.voteAverage))
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        HStack(alignment:.center, spacing: 8 ) {
                            Text("Budget: ")
                                .font(.body)
                                .foregroundColor(.black)
                            Text(String( details.budget))
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        HStack(alignment:.center, spacing: 8 ) {
                            Text("Languages: ")
                                .font(.body)
                                .foregroundColor(.black)
                            Text(details.spokenLanguages.map { $0.englishName }.joined(separator: ", "))
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        Text("overview: " + details.overview)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(10)
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchMovieDetails(movieID: movieID ?? nil)
        }
    }
    
    init(viewModel: MovieDetailsViewModel, movieID: String? = nil) {
        self.viewModel = viewModel
        self.movieID = movieID
    }
}

struct ContentView: View {
    @StateObject var viewModel = MovieDetailsViewModel()
    let movieID: String    
    var body: some View {
        NavigationView {
            MovieDetailsView(viewModel: viewModel, movieID: movieID)
        }
    }
    init(movieID: String) {
        self.movieID = movieID
    }
}
