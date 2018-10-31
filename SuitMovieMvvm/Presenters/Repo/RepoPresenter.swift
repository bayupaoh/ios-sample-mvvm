//
//  RepoPresenter.swift
//  SuitMovieMvvm
//
//  Created by Rifat Firdaus on 10/3/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RepoPresenterProtocol: BaseProtocol {}

class RepoPresenter: BaseViewModel {

    var view: RepoPresenterProtocol?
    var data = [Repo]()
    
    func load() {
        let result = realm.objects(Repo.self)
        var listData = [Repo]()
        if result.count > 0 {
            for dataRealm in result {
                let data = Repo(value: dataRealm.detached())
                listData.append(data)
            }
        }
        data.removeAll()
        data.append(contentsOf: listData)
    }
    
    func refresh(user: String) {
        self.pageStatus.currentPage = 1
        return self.next(user: user)
    }
    
    func next(user: String) {
        Observable.just(user)
            .flatMapLatest { user in self.service.searchRepo(user: user, params: self.params, page: self.pageStatus.currentPage, perPage: self.perPage) }
            .do(onNext:{ pagination in
                self.pageStatus = pagination.pageStatus
                if self.pageStatus.currentPage <= 1 {
                    self.data.removeAll()
                    self.removeAllModelsOf(type: Repo.self)
                }
                self.pageStatus.currentPage += 1
                self.data.append(contentsOf: pagination.data)
                self.saveListOfModels(data: pagination.data.detached())
                self.view?.showData()
            })
            .do(onError: { error in
                self.view?.showError(error: error)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
}
