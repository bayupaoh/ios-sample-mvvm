//
//  MovieCell.swift
//  SuitMovieMvvm
//
//  Created by Bayu Paoh on 31/10/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var descMovie: UILabel!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                titleMovie.text = movie.title ?? " "
                descMovie.text = movie.overview ?? " "
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
