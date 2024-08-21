//
//  DashBoardViewController.swift
//  MovieDatabaseApp
//
//  Created by Kishore B on 8/20/24.
//

import UIKit

struct Section {
    let title: CategoryTypes
    var isExpanded: Bool
    let items: [String]
}

enum CategoryTypes: String {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
    case allMovies = "All Movies"
}

class DashBoardViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
       var sectionsDetailsArray : [Section] = []
       var selectedOption: CategoryTypes? = nil
       var movies: [Movie] = []
       var filteredMovies: [Movie] = []
       var isSearching = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadSections()
        self.registerCells()
        searchBar.delegate = self
    }
    
    // MARK: - Additionla Functions
    func registerCells() {
        if #available(iOS 15.0, *) {
            tblVw.sectionHeaderTopPadding = 0
        }
        
        let cellIdentifiers = [
            "CategoryTitleTblVwCell",
            "TitleDetailsTblVwCell",
            "MovieDetailsTableViewCell" ]
        
        for identifier in cellIdentifiers {
            tblVw.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func loadSections() {
        guard let moviesList = parseMoviesData() else {
            print("Failed to parse movies data")
            return
        }
        
        self.movies = moviesList
        
        let years = getMoviesBasedOnCategory(from: movies, categoryType: .year)
        let genres = getMoviesBasedOnCategory(from: movies, categoryType: .genre)
        let directors = getMoviesBasedOnCategory(from: movies, categoryType: .directors)
        let actors = getMoviesBasedOnCategory(from: movies, categoryType: .actors)
        let allMovies = getMoviesBasedOnCategory(from: movies, categoryType: .allMovies)
            
        sectionsDetailsArray.append(Section(title: CategoryTypes.year, isExpanded: false, items: years ))
        sectionsDetailsArray.append(Section(title: CategoryTypes.genre, isExpanded: false, items: genres ))
        sectionsDetailsArray.append(Section(title: CategoryTypes.directors, isExpanded: false, items: directors ))
        sectionsDetailsArray.append(Section(title: CategoryTypes.actors, isExpanded: false, items: actors))
        sectionsDetailsArray.append(Section(title: CategoryTypes.allMovies, isExpanded: false, items: allMovies))
    }
    
    func getMoviesBasedOnCategory(from movies: [Movie], categoryType: CategoryTypes) -> [String] {
        
        switch categoryType {
            
        case .year:
            let yearsArray = movies.map { $0.year }
            let uniqueYears = Array(Set(yearsArray)).sorted()
            return uniqueYears
        case .genre:
            let genresArray = movies.map { $0.genre }
            let uniqueGenresArray = splitAndRemoveDuplicates(from: genresArray)
            return uniqueGenresArray
        case .directors:
            let directorsArray = movies.map { $0.director }
            let uniqueDirectorsArray = splitAndRemoveDuplicates(from: directorsArray)
            return uniqueDirectorsArray
        case .actors:
           let actorsArray = movies.map { $0.actors }
            let uniqueActorsArray = splitAndRemoveDuplicates(from: actorsArray)
            return uniqueActorsArray
        case .allMovies:
            return [""]
        }
    }
    func splitAndRemoveDuplicates(from genresArray: [String]) -> [String] {
        var allGenres = [String]()
        
        for genreString in genresArray {
            let genres = genreString.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            allGenres.append(contentsOf: genres)
        }
        
        let uniqueGenres = Set(allGenres)
        let sortedUniqueGenres = uniqueGenres.sorted()
        
        return sortedUniqueGenres
    }
    
}
// MARK: - UITableViewDelegate And UITableViewDataSource

extension DashBoardViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                isSearching = false
            } else {
                isSearching = true
                filteredMovies = searchMovies(with: searchText)
            }
            tblVw.reloadData()
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            isSearching = false
            searchBar.text = ""
            tblVw.reloadData()
        }

    func searchMovies(with query: String) -> [Movie] {
        return movies.filter { movie in
              movie.titleStr.localizedCaseInsensitiveContains(query) ||
              movie.genre.localizedCaseInsensitiveContains(query) ||
              movie.director.localizedCaseInsensitiveContains(query) ||
              movie.actors.localizedCaseInsensitiveContains(query) ||
              movie.year.localizedCaseInsensitiveContains(query)
          }
    }
}

// MARK: - UITableViewDelegate And UITableViewDataSource

extension DashBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : sectionsDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredMovies.count
        } else if sectionsDetailsArray[section].title == .allMovies {
            return sectionsDetailsArray[section].isExpanded ? movies.count : 0
        } else {
            return sectionsDetailsArray[section].isExpanded ? sectionsDetailsArray[section].items.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearching {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as! MovieDetailsTableViewCell

            cell.setData(with: filteredMovies[indexPath.row])
            
            return cell
        } else if sectionsDetailsArray[indexPath.section].title == .allMovies {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as! MovieDetailsTableViewCell

            cell.setData(with: movies[indexPath.row])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleDetailsTblVwCell", for: indexPath) as! TitleDetailsTblVwCell

            cell.titleLabel.text = sectionsDetailsArray[indexPath.section].items[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tblVw.dequeueReusableCell(withIdentifier: "CategoryTitleTblVwCell") as! CategoryTitleTblVwCell
        headerView.titleLabel.text = sectionsDetailsArray[section].title.rawValue
        headerView.section = section
        headerView.delegate = self
        headerView.selectedOption =  sectionsDetailsArray[section].title
        let isExpand = sectionsDetailsArray[section].isExpanded
        headerView.expandArrowIcon.image = isExpand ? UIImage(named: "chevron-down") : UIImage(named: "chevron-right")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isSearching ? 0 : 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectedMovieDetailsVC") as? SelectedMovieDetailsVC {
                nextVC.selectedMovie = filteredMovies[indexPath.row]
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if sectionsDetailsArray[indexPath.section].title == .allMovies {
            if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectedMovieDetailsVC") as? SelectedMovieDetailsVC {
                nextVC.selectedMovie = movies[indexPath.row]
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else {
            let selectedCategory = sectionsDetailsArray[indexPath.section].items[indexPath.row]
            let filteredData = self.searchMovies(with: selectedCategory)
            
            if filteredData.count > 0 {
                if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectedCategoryMoviesListVC") as? SelectedCategoryMoviesListVC {
                    nextVC.filteredMovies = filteredData
                    nextVC.selectedCategory = "\(selectedCategory) Movies"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            } else {
                self.toastMessage("No data found!")
            }
        }
    }

}


extension DashBoardViewController: CategoryTitleTblVwCellDelegate {
    
    func reloadTableViewSections(selectedSection: Int, selectedOption: CategoryTypes) {
        let isExpanded = sectionsDetailsArray[selectedSection].isExpanded
        sectionsDetailsArray[selectedSection].isExpanded = !isExpanded
        self.selectedOption = selectedOption

        tblVw.beginUpdates()
        tblVw.reloadSections(IndexSet(integer: selectedSection), with: .automatic)
        tblVw.endUpdates()
        tblVw.reloadData()
    }

}


