//
//  SearchMoviesViewController.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 09/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit
import MXSegmentedControl

class SearchMoviesViewController: UIViewController {
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var serchIndicator: UIActivityIndicatorView!
    @IBOutlet weak var categorySelector: MXSegmentedControl! {
        didSet{
            for source in MovieSource.allCases {
                categorySelector.append(title: source.rawValue)
            }
        }
    }
    
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            let cell = UINib(nibName: "SearchMovieCellTableViewCell", bundle: nil)
            searchTableView.register(cell, forCellReuseIdentifier: SearchMovieCellTableViewCell.identifier)
            searchTableView.tableFooterView = UIView()
        }
    }
    
    private lazy var presenter: SearchViewToSearchPresenterProtocol = {
        return SearchMoviesPresenter(view: self)
    }()
    
    var items:[Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func search(_ sender: Any) {
        if let query = movieSearchBar.text, !query.isEmpty {
            let source = MovieSource.allCases[categorySelector.selectedIndex]
            presenter.searchMovies(query, forSoure: source)
        } else {
            showErrorMessage("Debe ingresar un text para la busqueda")
        }
    }
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SearchMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieCellTableViewCell.identifier, for: indexPath) as! SearchMovieCellTableViewCell
        
        if let movie = items?[indexPath.row] {
            cell.fillCell(movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension SearchMoviesViewController: SearchPresenterToSearchViewProtocol {
    func showMovies(_ movies: [Movie]) {
        items?.removeAll()
        items = movies
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
    
    func isLoading(_ isLoading: Bool) {
        if isLoading {
            searchTableView.isHidden = true
            serchIndicator.startAnimating()
        } else {
            searchTableView.isHidden = false
            serchIndicator.stopAnimating()
        }
    }
    
    func showError(_ error: String) {
        showErrorMessage(error)
    }
    
    func navigateToViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

