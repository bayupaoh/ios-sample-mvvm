//
//  RepoLinkDetailViewController.swift
//  SuitMovieMvvm
//
//  Created by Rifat Firdaus on 10/3/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit
import WebKit

class RepoLinkDetailViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var presenter = RepoLinkDetailPresenter()
    lazy var loadingView = ViewManager.createLoadingFullScreen(offset: 64)
    
    static func instantiate(repo: Repo) -> RepoLinkDetailViewController {
        let controller = UIStoryboard.main.instantiateViewController(withIdentifier: RepoLinkDetailViewController.className()) as! RepoLinkDetailViewController
        controller.presenter.data = repo
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        presenter.view = self
        presenter.load(webView: webView)
    }
    
}

extension RepoLinkDetailViewController: RepoLinkDetailProtocol {
    func showLoading() {
        ViewManager.addSubView(loadingView: loadingView, to: webView)
    }
}

extension RepoLinkDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish")
        loadingView.removeFromSuperview()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("error")
        loadingView.removeFromSuperview()
    }
}
