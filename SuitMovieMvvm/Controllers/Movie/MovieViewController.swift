//
//  MovieViewController.swift
//  SuitMovieMvvm
//
//  Created by Bayu Paoh on 31/10/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:MovieViewModel?
    let refreshControl =  UIRefreshControl()
    var disposeBag = DisposeBag()
    
    static func instantiateNav() -> UIViewController {
        let nav = UIStoryboard.main.instantiateViewController(withIdentifier: MovieViewController.className()) as! UIViewController
        return nav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        setupDataBinding()
    }
    
    private func setupViewModel(){
        viewModel = MovieViewModel()
    }
    
    private func setupTableView(){
        tableView.register(MovieCell.loadNib(), forCellReuseIdentifier: MovieCell.className())
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.tintColor = .darkGray
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    @objc func handleRefresh(_ rc: UIRefreshControl) {
    }

    
    private func setupDataBinding(){
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let viewModelInput = MovieViewModel.Input(pullOfCollectionTrigger:pull,endOfCollectionTrigger:tableView.rx_reachedBottom.asDriverOnErrorJustComplete(),itemDidSelect:tableView.rx.itemSelected.asDriver())
        let output = viewModel?.loadData(input: viewModelInput)
        
        output?.movieCellViewModel
            .drive(tableView.rx.items){ tableView, index, model in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.className(), for: indexPath) as! MovieCell
            cell.movie = model
            return cell
        }.disposed(by: disposeBag)
        
        output?.selectMovie.drive(onNext:{ movie in
            print("\(movie.title)")
        })
        .disposed(by: disposeBag)
        
        output?.fetching
        .drive(tableView.refreshControl!.rx.isRefreshing)
        .disposed(by: disposeBag)
    }
 
    private func setupCell(row: Int, element: Movie, cell: MovieCell){
        cell.movie = element
    }
}
