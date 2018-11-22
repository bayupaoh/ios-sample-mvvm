//
//  MovieViewModelCell.swift
//  SuitMovieMvvm
//
//  Created by Bayu Paoh on 18/11/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import Foundation

struct MovieViewModelCell {
    var id : Int64 = 0
    var vote_count : Int = 0
    var video: Bool = false
    var vote_average: Double = 0
    var title: String?
    var popularity:Double = 0
    var poster_path:String?
    var original_language:String?
    var adult: Bool = false
    var original_title:String?
    var backdrop_path:String?
    var overview:String?
    var release_date:String?

    init(movie:Movie) {
        self.id=movie.id
        self.vote_count = movie.vote_count
        self.video = movie.video
        self.vote_average = movie.vote_average
        self.title = movie.title
        self.popularity = movie.popularity
        self.poster_path=movie.poster_path
        self.original_language = movie.original_language
        self.backdrop_path = movie.backdrop_path
        self.overview = movie.overview
        self.release_date = movie.release_date
    }
}
