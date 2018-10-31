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
    var movies: [Movie] = []
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
    }
    
    private func setupDataBinding(){
        viewModel?.movies.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.className(), cellType: MovieCell.self)){
                row, movie, cell in
                cell.movie = movie
            }.disposed(by: disposeBag)
    }
    
}
