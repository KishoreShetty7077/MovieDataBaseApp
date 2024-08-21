//
//  CategoryTitleTblVwCell.swift
//  MovieDatabaseApp
//
//  Created by Kishore B on 8/20/24.
//

import UIKit

import UIKit

// MARK: - CategoryTitleTblVwCellDelegate Protocol

protocol CategoryTitleTblVwCellDelegate: AnyObject {
    func reloadTableViewSections(selectedSection: Int, selectedOption: CategoryTypes)
}


class CategoryTitleTblVwCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tabBtn: UIButton!
    @IBOutlet weak var expandArrowIcon: UIImageView!
    
    // MARK: - Properties
    var section: Int = 0
    weak var delegate: CategoryTitleTblVwCellDelegate?
    var selectedOption: CategoryTypes = .year
    
    // MARK: - Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    @IBAction func tappedOnCellBtnAction(_ sender: UIButton) {
        delegate?.reloadTableViewSections(selectedSection: section, selectedOption: selectedOption)
    }
}
