//
//  WordDetailsViewController.swift
//  Werdd
//
//  Created by Chris Forbes on 11/23/23.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    let word: Word
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var definitionView: WordDetailsView = {
        let view = WordDetailsView(
            title: "Definition",
            partOfSpeech: word.partOfSpeech,
            descriptionText: word.definition,
            backgroundColor: UIColor(named: "Blue")
        )
        return view
    }()
    
    lazy var synonyms: WordDetailsView = {
        let hideSynonyms = word.synonyms == nil
        let synonymsText = word.synonyms?.joined(separator: ", ")
        let view = WordDetailsView(
            title: "Synonyms",
            partOfSpeech: nil,
            descriptionText: synonymsText,
            isHidden: hideSynonyms,
            backgroundColor: UIColor(named: "Green")
        )
        return view
    }()
    
    lazy var antonyms: WordDetailsView = {
        let hideAntonyms = word.antonyms == nil
        let antonymsText = word.antonyms?.joined(separator: ", ")
        let view = WordDetailsView(
            title: "Antonyms",
            partOfSpeech: nil,
            descriptionText: antonymsText,
            isHidden: hideAntonyms,
            backgroundColor: UIColor(named: "Pink")
        )
        return view
    }()
    
    lazy var examples: WordDetailsView = {
        let hideExamples = word.examples == nil
        let examplesText = word.examples?.joined(separator: "\n")
        let view = WordDetailsView(
            title: "Examples",
            partOfSpeech: nil,
            descriptionText: examplesText,
            isHidden: hideExamples,
            backgroundColor: UIColor(named: "Creamsicle")
        )
        return view
    }()
    
    init(word: Word) {
        self.word = word
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Light Gray")
        setupNavigation()
        setupUI()
    }
    
    private func setupUI() {
        setupScrollView()
        setupContentStackView()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.title = word.name
    }
    
    private func setupContentStackView() {
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(definitionView)
        contentStackView.addArrangedSubview(synonyms)
        contentStackView.addArrangedSubview(antonyms)
        contentStackView.addArrangedSubview(examples)
        
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(emptyView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            definitionView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}