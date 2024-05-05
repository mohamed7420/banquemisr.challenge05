//
//  NowPlayingViewController.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import UIKit
import Combine

class NowPlayingViewController: UIViewController {
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var shimmerView = MovieShimmerView.loadFromNib()
    
    private let viewModel = NowPlayingViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private var dataSource: UICollectionViewDiffableDataSource<Int, Movie>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        registerCell()
        fetchNowPlayingMovies()
        configureDataSource()
        setupViewBinding()
    }
    
    private func setupViews() {
        title = NSLocalizedString("Now Playing", comment: "")
        containerStackView.insertArrangedSubview(shimmerView, at: 0)
        shimmerView.isHidden = true
    }
    
    private func fetchNowPlayingMovies() {
        Task {
            do {
                try await viewModel.loadNowplayingMovies()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupViewBinding() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink {[weak self] movies in
                guard let self else { return }
                snapshot(movies: movies)
            }.store(in: &cancellables)
        
        viewModel.$movies
            .combineLatest(viewModel.$isLoading)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] movies, isLoading in
                guard let self else { return }
                shimmerView.isHidden = !isLoading
                collectionView.isHidden = isLoading
            }.store(in: &cancellables)
    }
    
    private func registerCell() {
        collectionView.delegate = self
        collectionView.collectionViewLayout = generateCollectionLayout()
        collectionView.register(UINib(nibName: MovieCVCell.className, bundle: nil),
                                forCellWithReuseIdentifier: MovieCVCell.className)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Movie>(collectionView: collectionView) {[unowned self] in
            return configureCell(collectionView: $0, indexPath: $1, movie: $2)
        }
    }
    
    private func snapshot(movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(movies, toSection: 0)
        dataSource?.apply(snapshot)
    }
    
    private func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        movie: Movie
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVCell.className, for: indexPath) as! MovieCVCell
       
        let cellViewModel = MovieCVCellViewModel(movie: movie)
        cell.configure(viewModel: cellViewModel)
        
        return cell
    }
    
    private func generateCollectionLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/6))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension NowPlayingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let movie = viewModel.selectedMovie(at: indexPath.row) {
            let vm = MovieDetailsViewModel(movie: movie)
            let vc = MovieDetailsViewController(viewModel: vm)
            show(vc, sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.movies.count > 19 && self.viewModel.movies.count - 1 == indexPath.row {
            viewModel.loadMoreMovies()
        }
    }
}
