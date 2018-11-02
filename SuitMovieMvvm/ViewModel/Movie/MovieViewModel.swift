//
//  MovieViewModel.swift
//  SuitMovieMvvm
//
//  Created by Bayu Paoh on 31/10/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieViewModel: BaseViewModel {
    //versi baru
    struct Input {
        let endOfCollectionTrigger: Driver<Void>
        let itemDidSelect: Driver<IndexPath>
    }
    
    struct Output {
        let movieCellViewModel: Driver<[Movie]>
        let selectMovie : Driver<Movie>
    }
    
    let apiKey = "1b2f29d43bf2e4f3142530bc6929d341"

    func loadData(input:Input) -> Output {
        let page = BehaviorRelay<Int>(value: 1)
        let items = BehaviorRelay<[Movie]>(value: [])
        let nextPageAvailable = BehaviorRelay<Bool>(value: true)
        
        let nextPageTrigger = input.endOfCollectionTrigger.withLatestFrom(nextPageAvailable.asDriver())
            .flatMapLatest { (available) -> Driver<Void> in
                return available ? Driver.just(()) : Driver.empty()
        }
        
        let results = nextPageTrigger
            .withLatestFrom(page.asDriver())
            .flatMapLatest { p -> Driver<[Movie]> in
                return self.service.favoriteMovie(apiKey: self.apiKey,page:p)
                .asDriverOnErrorJustComplete()
            }
            .map { result -> [Movie] in
                items.accept(items.value + result)
                page.accept(page.value + 1)
                nextPageAvailable.accept(!result.isEmpty)
                
                return items.value
        }
        
        let movieList = results.map{
            $0.enumerated().map{$1}
        }
        
        let selectedMovie = input.itemDidSelect
            .withLatestFrom(results) { (indexPath, results) -> Movie in
                return results[indexPath.row]
            }
        
        return Output(movieCellViewModel: movieList, selectMovie: selectedMovie)
    }
}
