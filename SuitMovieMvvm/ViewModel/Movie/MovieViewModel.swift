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
    var movies = Variable<[Movie]>([])
    
    init() {
        super.init()
        loadData(apiKey: "1b2f29d43bf2e4f3142530bc6929d341")
    }
    
    func loadData(apiKey:String){
        Observable.just(apiKey)
            .flatMapLatest { apiKey in self.service.favoriteMovie(apiKey: apiKey) }
            .do(onNext:{ data in
                self.movies.value = data
                self.saveListOfModels(data: data.detached())
            })
            .do(onError: { error in
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
