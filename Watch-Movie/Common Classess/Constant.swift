//
//  Constant.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import UIKit
import SwiftyJSON
import Foundation


// MARK: - Declare plist here.....
let plist = Bundle.main.infoDictionary!
let env =  plist["Settings"] as! [String : String]

let kBaseURL = env["baseUrl"]!
let kImageURL = env["imageUrl"]!
let kAPIKey = env["apiKey"]!
let kAccessToken = env["accessToken"]!
let kPopularMovies = "popular"
