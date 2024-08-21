//
//  RatingControl.swift
//  MovieDatabaseApp
//
//  Created by Kishore B on 8/20/24.
//

import UIKit

class RatingControl: UIView {

    private var ratings: [Rating] = []
    private let segmentedControl: UISegmentedControl = UISegmentedControl()
    private let ratingLabel: UILabel = UILabel()

    init(ratings: [Rating]) {
        super.init(frame: .zero)
        self.ratings = ratings
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Setup Segmented Control
        let sources = ratings.map { $0.source }
        segmentedControl.removeAllSegments()
        for (index, source) in sources.enumerated() {
            segmentedControl.insertSegment(withTitle: source, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(ratingSourceChanged), for: .valueChanged)

        // Setup Rating Label
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        ratingLabel.textAlignment = .center

        // Add subviews
        addSubview(segmentedControl)
        addSubview(ratingLabel)

        // Set constraints
        setupConstraints()

        // Set initial rating label
        updateRatingLabel()
    }

    private func setupConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor),

            ratingLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func ratingSourceChanged() {
        updateRatingLabel()
    }

    private func updateRatingLabel() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        let selectedRating = ratings[selectedIndex]
        ratingLabel.text = "\(selectedRating.source): \(selectedRating.value)"
    }
}
