//
//  ViewController.swift
//  Werdd
//
//  Created by Chris Forbes on 4/17/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    var words: [WordDetail]?
    var selectedWord: String?
    
    let spinnerViewController = SpinnerViewController()
    let favoriteWordsViewController = FavoriteWordsViewController()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.appTitle
        label.font = viewModel.appTitleFont
        return label
    }()
    
    lazy var favoritesListButton: UIButton = {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "heart.text.square.fill", withConfiguration: symbolConfiguration)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = viewModel.favoriteListButtonColor
        button.addTarget(self, action: #selector(favoritesListButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var mainWordContainerView: WordContainerView = {
        let view = WordContainerView { [weak self] in
            self?.updateMainWordContainerWithRandomWord()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width / 2.2, height: view.frame.size.width / 3.5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(WordCollectionViewCell.self, forCellWithReuseIdentifier: WordCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    lazy var searchView: SearchView = {
        let searchView = SearchView(searchDelegate: self)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.layer.cornerRadius = 20

        // Top right corner, Top left corner
        searchView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return searchView
    }()
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewModel.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = false
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI() {
        setupHeader()
        setupContainerView()
        setUpSearchView()
        setupCollectionView()
    }
    
    func setupHeader() {
        headerStackView.addArrangedSubview(appTitleLabel)
        headerStackView.addArrangedSubview(favoritesListButton)
        view.addSubview(headerStackView)
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupContainerView() {
        view.addSubview(mainWordContainerView)
        NSLayoutConstraint.activate([
            mainWordContainerView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 30),
            mainWordContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            mainWordContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainWordContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])
    }
    
    func setUpSearchView() {
        view.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: mainWordContainerView.bottomAnchor, constant: 35),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    /* MARK: Actions */
    
    @objc func favoritesListButtonPressed() {
        navigationController?.pushViewController(FavoriteWordsViewController(), animated: true)
    }
    
    func updateMainWordContainerWithRandomWord() {
        addSpinner()
        Task {
            do {
                try await viewModel.refreshRandomWord()
                DispatchQueue.main.async {
                    self.mainWordContainerView.wordTitleLabel.text = self.viewModel.randomWordName
                    self.mainWordContainerView.partsOfSpeechLabel.text = self.viewModel.randomWordPartOfSpeech
                    self.mainWordContainerView.definitionLabel.text = self.viewModel.randomWordDefinition
                    self.removeSpinner()
                }
            } catch {
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
            }
        }
    }
    
    func addSpinner() {
        addChild(spinnerViewController)
        spinnerViewController.view.frame = view.frame
        view.addSubview(spinnerViewController.view)
        spinnerViewController.didMove(toParent: self)
    }
    
    func removeSpinner() {
        spinnerViewController.willMove(toParent: nil)
        spinnerViewController.view?.removeFromSuperview()
        spinnerViewController.removeFromParent()
    }


}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.wordDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCollectionViewCell.identifier, for: indexPath) as? WordCollectionViewCell else {
            print("Expected WordTableViewCell but found nil")
            return UICollectionViewCell()
        }
        cell.update(viewModel.wordDetails?[indexPath.row], word: viewModel.selectedWord)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedWord = viewModel.selectedWord,
              let selectedWordDetails = viewModel.wordDetails?[indexPath.row] else {
            return
        }
        navigationController?.pushViewController(WordDetailsViewController(wordDetail: selectedWordDetails, selectedWord: selectedWord), animated: true)
    }
}

extension HomeViewController: SearchDelegate {
    func search(forWord word: String?) {
        guard let word = word, !word.isEmpty else {
            print("missing word")
            return
        }
        addSpinner()
        Task {
            do {
                try await viewModel.fetchSpecificWord(word: word)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.removeSpinner()
                }
            } catch {
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
            }
        }
    }
}

