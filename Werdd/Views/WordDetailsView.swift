//
//  WordDetailsView.swift
//  Werdd
//
//  Created by Chris Forbes on 11/24/23.
//

import UIKit

class WordDetailsView: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isHidden = true
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-SemiBold", size: 12)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-Light", size: 18)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Bold", size: 14)
        return label
    }()
    
    let title: String?
    let partOfSpeech: String?
    let descriptionText: String?
    
    init(title: String?,
         partOfSpeech: String?,
         descriptionText: String?,
         isHidden: Bool = false,
         backgroundColor: UIColor? = .white) {
        self.title = title
        self.partOfSpeech = partOfSpeech
        self.descriptionText = descriptionText
        
        super.init(frame: .zero)
        self.isHidden = isHidden
        self.backgroundColor = backgroundColor
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 20
        
        titleLabel.text = title
        partsOfSpeechLabel.text = partOfSpeech
        descriptionLabel.text = descriptionText
        
        partsOfSpeechLabel.isHidden = partOfSpeech == nil
        
        setupDescriptionStackView()
        setupTitleLabel()
        setupStackView()
    }
    
    private func setupDescriptionStackView() {
        descriptionStackView.addArrangedSubview(partsOfSpeechLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionStackView)
    }
    
    private func setupTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
