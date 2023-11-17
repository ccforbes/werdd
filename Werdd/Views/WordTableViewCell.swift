//
//  WordTableViewCell.swift
//  Werdd
//
//  Created by Chris Forbes on 11/16/23.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    static let identifier: String = "WordTableViewCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Creamsicle")
        view.layer.cornerRadius = 20
        return view
    }()
    
    var wordTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Bold", size: 16)
        return label
    }()
    
    var partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Italic", size: 12)
        return label
    }()
    
    var definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Light", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        containerView.addSubview(wordTitleLabel)
        containerView.addSubview(definitionLabel)
        containerView.addSubview(partsOfSpeechLabel)
        
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            wordTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            wordTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.trailingAnchor, constant: 4),
            partsOfSpeechLabel.bottomAnchor.constraint(equalTo: wordTitleLabel.bottomAnchor),
            
            definitionLabel.topAnchor.constraint(equalTo: wordTitleLabel.bottomAnchor, constant: 5),
            definitionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            definitionLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4)
        ])
    }
    
    func update(with word: Word) {
        wordTitleLabel.text = word.name
        definitionLabel.text = word.definition
        partsOfSpeechLabel.text = word.partOfSpeech
    }
}
