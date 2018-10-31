//
//  RepoLinkDetailPresenter.swift
//  SuitMovieMvvm
//
//  Created by Rifat Firdaus on 10/3/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit

protocol RepoLinkDetailProtocol {
    func showLoading()
}

class RepoLinkDetailPresenter: BaseViewModel {
    
    var view: RepoLinkDetailProtocol?
    var data: Repo?
    
    func load(webView: WKWebView) {
        if let data = data {
            if let urlString = data.htmlUrl, let url = URL(string: urlString) {
                view?.showLoading()
                webView.load(URLRequest(url: url))
            }
        }
    }
    
}
