//
//  ViewController.swift
//  Werdd
//
//  Created by Chris Forbes on 4/17/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let words: [Word] = [
        Word(name: "antelope chipmunk", definition: "small ground squirrel of western United States", partOfSpeech: "noun"),
        Word(name: "auricular artery", definition: "artery that supplies blood to the ear", partOfSpeech: "noun"),
        Word(name: "electric circuit", definition: "an electrical device that provides a path for electrical current to flow", partOfSpeech: "noun"),
        Word(name: "punic", definition: "of or relating to or characteristic of ancient Carthage or its people or their language", partOfSpeech: "adjective"),
        Word(name: "glib", definition: "artfully persuasive in speech", partOfSpeech: "adjective"),
        Word(name: "appetite", definition: "a feeling of craving something", partOfSpeech: "noun"),
        Word(name: "unsay", definition: "take back what one has said", partOfSpeech: "verb"),
        Word(name: "golf links", definition: "a golf course that is built on sandy ground near a shore", partOfSpeech: "verb"),
        Word(name: "unbarreled", definition: "not in a barrel", partOfSpeech: "adjective"),
        Word(name: "authoratively", definition: "in an authorative and magisterial manner", partOfSpeech: "adverb   "),
    ]
    
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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

