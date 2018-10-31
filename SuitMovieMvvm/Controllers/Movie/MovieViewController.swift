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
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.className(), cellType: MovieCell.self))(setupCell)
            .disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Movie.self))
            .bind { [unowned self] indexPath, model in
                self.tableView.deselectRow(at: indexPath, animated: true)
                print("Selected \(model.title) at \(indexPath)")
            }
            .disposed(by: disposeBag)
    }
 
    private func setupCell(row: Int, element: Movie, cell: MovieCell){
        cell.movie = element
    }
}
