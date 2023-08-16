//
//  MovieCell.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import UIKit
import Kingfisher

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    var movieObjectList : DashboardModel? {
        didSet {
            guard let movieObject = movieObjectList else {
                return
            }
            
            movieImageView.kf.setImage(with: URL(string: movieObject.poster_path), placeholder:UIImage(named: "icon_image_placeholder"), completionHandler: { result in
                switch result {
                case .success:
                    self.movieImageView.contentMode = .scaleToFill
                case .failure (let error):
                    print("failure Error: \(error)")
                }
            })
            
        }
    }

}
