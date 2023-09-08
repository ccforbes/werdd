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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Light Gray")
        setupUI()
    }
    
    func setupUI() {
        setupAppTitle()
        setupContainerView()
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
            mainWordContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
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

