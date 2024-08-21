//
//  MovieDetailsTableViewCell.swift
//  MovieDatabaseApp
//
//  Created by Kishore B on 8/20/24.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    // MARK: - Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Optionally configure the view for the selected state
    }
    
    // MARK: - Configuration
    func setData(with movie: Movie?) {
        configureUI()
        
        if let posterURL = URL(string: movie?.poster ?? "") {
            img.loadImage(from: posterURL, placeholder: UIImage(named: "imgNotAvailable"))
        }
        
        titleLabel.text = movie?.titleStr
        languagesLabel.text = movie?.language
        yearLabel.text = movie?.year
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        bgView.applyCardShadow()
    }
}
