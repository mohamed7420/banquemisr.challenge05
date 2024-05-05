//
//  MovieDetailsViewController.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreIdsLabel: UILabel!
    @IBOutlet weak var releaseNoteLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: MovieDetailsViewModel
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        titleLabel.text = viewModel.title
        overviewTextView.text = viewModel.overview
        genreIdsLabel.text = viewModel.genreIds
        releaseNoteLabel.text = viewModel.releaseDate
        genreIdsLabel.isHidden = viewModel.genreIds.isEmpty
        
        activityIndicator.startAnimating()
        ImageLoader.loadImage(from: viewModel.imageURL) {[weak self] image in
            guard let self else { return }
            activityIndicator.stopAnimating()
            
            if let image = image {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            } else {
                self.movieImageView.image = UIImage(named: "image_placeholder")
            }
        }
    }
}

