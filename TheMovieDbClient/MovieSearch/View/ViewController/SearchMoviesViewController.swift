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
    
    @IBOutlet weak var movieSearchBar: UISearchBar!{
        didSet {
            movieSearchBar.delegate = self
        }
    }
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
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var serchIndicator: UIActivityIndicatorView!
    
    private lazy var presenter: SearchViewToSearchPresenterProtocol = {
        return SearchMoviesPresenter(view: self)
    }()
    
    var items:[Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func search(_ sender: Any) {
        if let query = movieSearchBar.text, !query.isEmpty {
            view.endEditing(true)
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

extension SearchMoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = items?[indexPath.row] {
            let detailVC = MovieDetailViewController(movieId: movie.id, inSource: movie.source)
            navigationController?.pushViewController(detailVC, animated: true)
            detailVC.navigationController?.navigationBar.isHidden = false
        }
    }
}

extension SearchMoviesViewController: SearchPresenterToSearchViewProtocol {
    func showMovies(_ movies: [Movie]) {
        items?.removeAll()
        if movies.count > 0 {            
            items = movies
            searchTableView.reloadData()
        } else {
            showMessage("No se encontraron peliculas")
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

