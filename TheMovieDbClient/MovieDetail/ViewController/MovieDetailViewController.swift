//
//  MovieDetailViewController.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 02/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    let movieId: Int?
    let movieSource: MovieSource?
    
    var movie: Movie?
    
    @IBOutlet weak var mediaCollectionView: UICollectionView! {
        didSet {
            let cell = UINib(nibName: "HeaderCollectionViewCell", bundle: nil)
            mediaCollectionView.register(cell, forCellWithReuseIdentifier: "HeaderCellIdentifier")
            mediaCollectionView.backgroundColor = .clear
            mediaCollectionView.isPagingEnabled = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var loadingVideoView: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    //Worst ever
    private let restClient: IRestClientService = RestClientService()
    private let persistenceService: IPersistenceService = PersistenceService()
    
    //Inits
    init(movieId: Int, inSource source: String) {
        self.movieId = movieId
        self.movieSource = MovieSource(rawValue: source)
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        movieId = nil
        movieSource = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovie()
    }
    
    func loadMovie() {
        guard let movieId = movieId, let movieSource = movieSource else {
            closeViewController()
            return
        }
        
        loadingView.isHidden = false
        
        restClient.fetchMovie(movieId: movieId, inSource: movieSource.encodeToParam()) { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                do {
                    let extraParams: [CodableParamKey : String] = [CodableParamKey.movieSource: movieSource.rawValue]
                    self.movie = try self.persistenceService.persistEntity(response, extraParameters: extraParams)
                    self.updateView()
                } catch {
                    print(error)
                    self.closeViewController()
                }
            } else {
                self.closeViewController()
            }
        }
    }
    
    func closeViewController() {
        navigationController?.popViewController(animated: true)
        showErrorMessage("Hubo un error al cargar la pelicula")
    }
    
    func updateView() {
        guard let movie = movie else {
            return
        }
        
        titleLabel.text = movie.title
        
        if let releaseDate = movie.releaseDate {
            releaseDateLabel.text = String(DateHelper.sharedInstance.componentFromDate(releaseDate, component: .year))
        }
        
        scoreLabel.text = String(movie.voteAverage)
        overviewLabel.text = movie.overview
        
        mediaCollectionView.reloadData()
        
        loadingView.isHidden = true
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.movieTrailers()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCellIdentifier", for: indexPath) as! HeaderCollectionViewCell
        if let video = movie?.movieTrailers()?[indexPath.row] {
            cell.fillCell(withVideo: video)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movie?.movieTrailers()?[indexPath.row], let movieUrl = movie.videoUrl() {
            loadingVideoView.isHidden = false
            playVideo(videoURL: movieUrl, completionHandler: { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.loadingVideoView.isHidden = true
                }
            })
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = view.frame.width
        return CGSize(width: cellWidth, height: cellWidth * 0.75)
    }
}
