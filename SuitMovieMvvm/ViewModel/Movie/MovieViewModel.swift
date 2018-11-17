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


struct MovieViewModel {
    //versi baru
    public var service = SMEngineService.instance
    public var disposeBag = DisposeBag()

    struct Input {
        let pullOfCollectionTrigger: Driver<Void>
        let endOfCollectionTrigger: Driver<Void>
        let itemDidSelect: Driver<IndexPath>
    }
    
    struct Output {
        let movieCellViewModel: Driver<[Movie]>
        let selectMovie : Driver<Movie>
        let fetching: Driver<Bool>
    }
    let apiKey = "1b2f29d43bf2e4f3142530bc6929d341"

    func loadData(input:Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let page = BehaviorRelay<Int>(value: 1)
        let items = BehaviorRelay<[Movie]>(value: [])
        let nextPageAvailable = BehaviorRelay<Bool>(value: true)
        
        var movieList: Driver<[Movie]>?

        let pullPageTrigger = input.pullOfCollectionTrigger
        
        let nextPageTrigger = input.endOfCollectionTrigger.withLatestFrom(nextPageAvailable.asDriver())
            .flatMapLatest { (available) -> Driver<Void> in
                return available ? Driver.just(()) : Driver.empty()
        }
        
        let resultsNextPage = nextPageTrigger
            .withLatestFrom(page.asDriver())
            .flatMapLatest { p -> Driver<[Movie]> in
                return self.service.favoriteMovie(apiKey: self.apiKey,page:p)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { result -> [Movie] in
                                items.accept(items.value + result)
                                page.accept(page.value + 1)
                                nextPageAvailable.accept(!result.isEmpty)                
                return items.value
        }

        let results = pullPageTrigger
            .flatMapLatest { p -> Driver<[Movie]> in
                return self.service.favoriteMovie(apiKey: self.apiKey,page:1)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
            }
            .map { result -> [Movie] in
                items.accept(result)
                page.accept(2)
                return items.value
        }
        
        let movieListPull = results.map{
            $0.enumerated().map{$1}
        }
        
        let movieListNext = resultsNextPage.map{
            $0.enumerated().map{$1}
        }
        
        movieList = Driver.merge(movieListPull,movieListNext)
        
        let selectedMovie = input.itemDidSelect
            .withLatestFrom(results) { (indexPath, results) -> Movie in
                return results[indexPath.row]
            }
        
        let fetching = activityIndicator.asDriver()
        return Output(movieCellViewModel: movieList!, selectMovie: selectedMovie,fetching: fetching)
    }
}
