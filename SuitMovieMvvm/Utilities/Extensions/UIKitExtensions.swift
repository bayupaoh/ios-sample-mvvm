//
//  UIKitExtensions.swift
//  SuitMovieMvvm
//
//  Created by Bayu Paoh on 02/11/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension UIScrollView {
    public var rx_reachedBottom: Observable<Void> {
        return rx.contentOffset
            .debounce(0.025, scheduler: MainScheduler.instance)
            .flatMap { [weak self] contentOffset -> Observable<Void> in
                guard let scrollView = self else {
                    return Observable.empty()
                }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                
                return y >= threshold ? Observable.just(()) : Observable.empty()
        }
    }
}

extension UIRefreshControl {
    public var rx_didPullRefresh : Observable<Void> {
        return rx.controlEvent(.valueChanged)
            .debounce(0.025, scheduler: MainScheduler.instance)
            .flatMap{[weak self] refreshControl -> Observable<Void> in
                guard let refresh = self else {
                    return Observable.empty()
                }
                
                return refresh.isRefreshing ? Observable.just(()) : Observable.empty()
        }
    }
}
