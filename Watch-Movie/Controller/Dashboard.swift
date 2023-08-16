//
//  Dashboard.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import UIKit

class Dashboard: UIViewController {

    @IBOutlet weak var DashTableView: UITableView!
        
    private var currentPage = 1
    
    let dataSource = DashBoardDataSource()
    lazy var viewModel : DashboardViewModel = {
        let viewModel = DashboardViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Popular Movies"
        
        /// Pass view controller instance to dataSource class....
        self.dataSource.getViewController(self)
        
        /// Set tableview dataSource and Delegate....
        self.DashTableView.delegate = dataSource
        self.DashTableView.dataSource = dataSource
        
        /// Calling API...
        self.getPopularMovieList { _ in}
        
        dataSource.getMoviesData = { completion in
            self.currentPage += 1
            self.getPopularMovieList { success in
                completion(success)
            }
        }
    }
    
    func getPopularMovieList(_ completion: @escaping (_ success: Bool) -> Void) {
        /// Get Movie list from server and add to dataSource...
        self.viewModel.getPopularMovieList(currentPage: currentPage) { success, movieModel in
            if success {
                self.currentPage == 1 ? self.dataSource.data.value = movieModel! : self.dataSource.data.value.append(contentsOf: movieModel!)
                self.DashTableView.reloadData()
            }
            completion(success)
        }
    }    
}
