//
//  DashBoardDataSource.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import UIKit
import SwiftUI
import Foundation


class DashBoardDataSource: GenericDataSource<DashboardModel>, UITableViewDataSource {
    
    var viewController : UIViewController?
    var isLoadingAPI = false

    var getMoviesData: ((_ completion: @escaping (_ success: Bool) -> Void) -> Void)?

    
    func getViewController(_ viewController: UIViewController)  {
        self.viewController = viewController
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        cell.selectionStyle = .none
        let movieObject : DashboardModel = data.value[indexPath.row]
        cell.movieObjectList = movieObject
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 530
    }
}

// MARK: - UITableView Delegate Method here...
extension DashBoardDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = MovieDetailsViewModel()
        let movieObject : DashboardModel = data.value[indexPath.row]
        let detailsPage = MovieDetailsView(viewModel: viewModel, movieID: movieObject.id)
        let hostingController = UIHostingController(rootView: detailsPage)
        self.viewController?.navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.value.count - 1 && !isLoadingAPI {
            isLoadingAPI = true
            getMoviesData? { success in
                if success {
                    self.isLoadingAPI = false
                }
            }
        }
    }
}
