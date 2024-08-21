//
//  SelectedMovieDetailsVC.swift
//  MovieDatabaseApp
//
//  Created by Kishore B on 8/20/24.
//

import UIKit

class SelectedMovieDetailsVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var castAndCrewLabel: UILabel!
    @IBOutlet weak var releasedDataLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingVw: UIView!
    
    // MARK: - Properties
    var selectedMovie: Movie?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureRatingControl()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        guard let movie = selectedMovie else { return }
        
        titleLabel.text = movie.titleStr
        plotLabel.text = movie.plot
        castAndCrewLabel.text = "NA"
        releasedDataLabel.text = movie.released
        genreLabel.text = movie.genre
        
        if let imageURL = URL(string: movie.poster) {
            img.loadImage(from: imageURL, placeholder: UIImage(named: "imgNotAvailable"))
        }
    }
    
    private func configureRatingControl() {
        guard let ratings = selectedMovie?.ratings else { return }
        
        let ratingControl = RatingControl(ratings: ratings)
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        
        ratingVw.addSubview(ratingControl)
        
        NSLayoutConstraint.activate([
            ratingControl.topAnchor.constraint(equalTo: ratingVw.topAnchor),
            ratingControl.leadingAnchor.constraint(equalTo: ratingVw.leadingAnchor),
            ratingControl.trailingAnchor.constraint(equalTo: ratingVw.trailingAnchor),
            ratingControl.bottomAnchor.constraint(equalTo: ratingVw.bottomAnchor)
        ])
    }
}
