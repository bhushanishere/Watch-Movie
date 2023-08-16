//
//  DashboardViewModel.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import Foundation
import SwiftyJSON

struct DashboardViewModel {
    
    weak var dataSource : GenericDataSource<DashboardModel>?
    var onErrorHandling : ((Error) -> Void)?
    
    init(dataSource : GenericDataSource<DashboardModel>?) {
        self.dataSource = dataSource
    }

    func getPopularMovieList(currentPage : Int, completionBlock:@escaping(Bool ,[DashboardModel]?) -> ()) {
        
        RestClient().callApi(api: kPopularMovies + "?page=\(currentPage)&", completion: { (result) in
            switch result {
            case.success(let response):
                let json = JSON(response)
                print("json --->", json)
                var movieModel : [DashboardModel] = []
                if let movieResult = json["results"].array {
                    for movie in movieResult {
                        movieModel.append(DashboardModel(json: movie))
                    }
                }
                completionBlock(true, movieModel)
                
            case .failure(let error) :
                print("Error: \(error.localizedDescription)")
                completionBlock(false, [])
            }
            
        }, type: .GET, data: nil, isAbsoluteURL: false, headers: nil, isSilent: false, jsonSerialize: false)
    }
}
