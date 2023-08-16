//
//  DashboardModel.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import Foundation
import SwiftyJSON
import SVProgressHUD

// MARK: - WelcomeElement
struct DashboardModel: Codable {
    var id, title, poster_path : String
    init(json : JSON) {
        id = json["id"].stringValue
        title = json["title"].stringValue
        poster_path = kImageURL + json["poster_path"].stringValue
    }
}
