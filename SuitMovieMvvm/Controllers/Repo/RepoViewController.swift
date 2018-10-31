//
//  RepoViewController.swift
//  SuitMovieMvvm
//
//  Created by Rifat Firdaus on 10/3/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit
import SVPullToRefresh

class RepoViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var presenter = RepoPresenter()
    
    var searchController: UISearchController? = nil
    var timer: Timer?
    
    static func instantiateNav() -> UINavigationController {
        let nav = UIStoryboard.main.instantiateViewController(withIdentifier: "RepoViewControllerNav") as! UINavigationController
        return nav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let searchText = self.searchController?.searchBar.text {
            self.presenter.refresh(user: searchText)
        }
    }

    func setupTableView() {
        searchController = UISearchController(searchResultsController: nil)
        searchController!.searchBar.delegate = self
        searchController!.searchResultsUpdater = self
        searchController!.hidesNavigationBarDuringPresentation = false
        searchController!.dimsBackgroundDuringPresentation = false
        searchController!.searchBar.sizeToFit()
        
        searchController!.searchBar.text = "scotteg"
        tableView.tableHeaderView = searchController!.searchBar
        tableView.tableHeaderView?.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepoCell.loadNib(), forCellReuseIdentifier: RepoCell.className())
        tableView.addPullToRefresh {
            if let searchText = self.searchController?.searchBar.text {
                self.presenter.refresh(user: searchText)
            }
        }
        tableView.addInfiniteScrolling {
            if let searchText = self.searchController?.searchBar.text {
                self.presenter.next(user: searchText)
            } else {
                self.tableView.infiniteScrollingView.stopAnimating()
            }
        }
    }
    
    @objc func searchText(sender: Any?) {
        tableView.triggerPullToRefresh()
    }
}

extension RepoViewController: RepoPresenterProtocol {
    func showData() {
        if self.presenter.data.count == 0 {
            self.tableView.infiniteScrollingView.enabled = false
        } else {
            self.tableView.infiniteScrollingView.enabled = true
        }
        tableView.pullToRefreshView.stopAnimating()
        tableView.infiniteScrollingView.stopAnimating()
        tableView.reloadData()
    }
    
    func showError(error: Error?) {
        tableView.pullToRefreshView.stopAnimating()
    }
}

extension RepoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.className(), for: indexPath) as! RepoCell
        cell.repo = presenter.data[indexPath.row]
        return cell
    }
}

extension RepoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = RepoLinkDetailViewController.instantiate(repo: presenter.data[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension RepoViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchText(sender:)), userInfo: nil, repeats: false)
    }
}

extension RepoViewController: UISearchBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
