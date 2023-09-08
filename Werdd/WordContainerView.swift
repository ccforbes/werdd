//
//  WordContainerView.swift
//  Werdd
//
//  Created by Chris Forbes on 9/7/23.
//

import UIKit

class WordContainerView: UIView {
    
    var completion: (() -> Void)?
    
    var wordTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Programming."
        label.font = UIFont(name: "Rubik-Bold", size: 24)
        return label
    }()
    
    var partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "noun"
        label.font = UIFont(name: "Rubik-Italic", size: 14)
        return label
    }()
    
    var definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "creating a sequence of instructions to enable the computer to do something"
        label.font = UIFont(name: "Rubik-Light", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var randomWordButton: RandomWordButton = {
        let button = RandomWordButton(frame: .zero, completion: completion)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(completion: (() -> Void)?) {
        self.completion = completion
        super.init(frame: .zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: "Blue")
        layer.cornerRadius = 30
        setupWordTitle()
        setupParsOfSpeech()
        setupDefinition()
        setupRandomWordButton()
    }
    
    private func setupWordTitle() {
        addSubview(wordTitleLabel)
        NSLayoutConstraint.activate([
            wordTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            wordTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }

    private func setupParsOfSpeech() {
        addSubview(partsOfSpeechLabel)
        NSLayoutConstraint.activate([
            partsOfSpeechLabel.bottomAnchor.constraint(equalTo: wordTitleLabel.bottomAnchor, constant: -4),
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.trailingAnchor, constant: 5),
            partsOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }

    private func setupDefinition() {
        addSubview(definitionLabel)
        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: wordTitleLabel.bottomAnchor, constant: 20),
            definitionLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupRandomWordButton() {
        addSubview(randomWordButton)
        NSLayoutConstraint.activate([
            randomWordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            randomWordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
