//
//  MainMovieListViewController.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 27/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit
import PureLayout
import MXSegmentedControl

class MainMovieListViewController: UIViewController {
    
    //private
    private let cellInsets = UIEdgeInsets(top: 0.0, left: 7.5, bottom: 0.0, right: 7.5)
    private let collectionViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    private var itemsByCategory = [String : [Movie]]()
    
    private lazy var presenter: ViewToPresenterProtocol = {
       return MainMovieListPresenter(view: self)
    }()

    //Outlets
    @IBOutlet weak var movieCollectionView: UICollectionView! {
        didSet {
            let cell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
            movieCollectionView.register(cell, forCellWithReuseIdentifier: "MovieCellIdentifier")
            movieCollectionView.contentInset = collectionViewInsets
            movieCollectionView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var categorySelector: MXSegmentedControl! {
        didSet {
            categorySelector.addTarget(self, action: #selector(changeIndex(segmentedControl:)), for: .valueChanged)
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movieSource: MovieSource?
    
    //Inits
    init(movieSource: MovieSource) {
        super.init(nibName: "MainMovieListViewController", bundle: nil)
        presenter.defineMovieSource(movieSource)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.initView()
    }
    
    // TO-DO: Add option to force refresh
    func updateDataSource(withMovies movies: Array<Movie>, forCategory category: String, forceRefresh    : Bool = false) {
        
        if itemsByCategory.keys.contains(category) {
            itemsByCategory[category]?.append(contentsOf: movies)
        } else {
            itemsByCategory[category] = movies
        }
    }
    
    func itemsForSelectedCategory() -> [Movie]? {
        let selectedCategory = presenter.categoryForIndex(categorySelector.selectedIndex)
        return itemsByCategory[selectedCategory.rawValue]
    }
    
    @objc func changeIndex(segmentedControl: MXSegmentedControl) {
        presenter.didChangeSelectedCategory(toIndexCategory: segmentedControl.selectedIndex)
    }
}

extension MainMovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsForSelectedCategory()?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCellIdentifier", for: indexPath) as! MovieCollectionViewCell
        if let items = itemsForSelectedCategory() {
            cell.fillCell(withMovie: items[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = itemsForSelectedCategory()?[indexPath.row] {
            presenter.didSelectMovie(selectedItem)
        }
    }
}

extension MainMovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width / 2) - cellInsets.left - cellInsets.right
        return CGSize(width: cellWidth, height: cellWidth * 1.8)
    }
}

extension MainMovieListViewController: PresenterToViewProtocol {
    func updateCategories(_ categories: [String]) {
        categories.forEach { category in categorySelector.append(title: category) }
    }
    
    func showMovies(_ movies: Array<Movie>, forCategory category: String) {
        updateDataSource(withMovies: movies, forCategory: category)
        
        //When we are working with pagination we have to take care of the scroll view position
        movieCollectionView.reloadData()
    }
    
    func isLoading(_ isLoading: Bool) {
        activityIndicator.isHidden = !isLoading
        categorySelector.isUserInteractionEnabled = !isLoading
        movieCollectionView.isHidden = isLoading
    }
    
    func showError(_ error: String) {
        showErrorMessage(error)
    }
    
    //This should be in the router but to simplify the exercise I have decided put it here.
    func navigateToViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
