//
//  SelectedCategoryMoviesListVC.swift
//  MovieDatabaseApp
//
//  Created by Kishore B on 8/20/24.
//

import UIKit

class SelectedCategoryMoviesListVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    @IBOutlet weak var tblVw: UITableView!
    
    // MARK: - Properties
    var selectedCategory: String = ""
    var filteredMovies: [Movie] = []

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        selectedCategoryLabel.text = selectedCategory
        registerCells()
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "MovieDetailsTableViewCell", bundle: nil)
        tblVw.register(nib, forCellReuseIdentifier: "MovieDetailsTableViewCell")
        tblVw.delegate = self
        tblVw.dataSource = self
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension SelectedCategoryMoviesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as? MovieDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(with: filteredMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "SelectedMovieDetailsVC") as? SelectedMovieDetailsVC else {
            return
        }
        
        nextVC.selectedMovie = filteredMovies[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
