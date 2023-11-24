//
//  ViewController.swift
//  Werdd
//
//  Created by Chris Forbes on 4/17/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let words: [Word] = WordsDataSource().words
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.font = UIFont(name: "Rubik-SemiBold", size: 36)
        return label
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Light Gray")
        navigationController?.navigationBar.prefersLargeTitles = false
        setupUI()
    }
    
    func setupUI() {
        setupAppTitle()
        setupContainerView()
        setupCollectionView()
    }
    
    func setupAppTitle() {
        view.addSubview(appTitleLabel)
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
        ])
    }
    
    func setupContainerView() {
        view.addSubview(mainWordContainerView)
        NSLayoutConstraint.activate([
            mainWordContainerView.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 30),
            mainWordContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            mainWordContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainWordContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: mainWordContainerView.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    /* MARK: Actions */
    
    func updateMainWordContainerWithRandomWord() {
        let randomWord = words.randomElement()
        mainWordContainerView.wordTitleLabel.text = randomWord?.name
        mainWordContainerView.partsOfSpeechLabel.text = randomWord?.partOfSpeech
        mainWordContainerView.definitionLabel.text = randomWord?.definition
    }


}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCollectionViewCell.identifier, for: indexPath) as? WordCollectionViewCell else {
            print("Expected WordTableViewCell but found nil")
            return UICollectionViewCell()
        }
        cell.update(with: words[indexPath.row])
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(WordDetailsViewController(word: words[indexPath.row]), animated: true)
    }
}

