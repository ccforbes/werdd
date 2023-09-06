//
//  ViewController.swift
//  Werdd
//
//  Created by Chris Forbes on 4/17/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.font = UIFont(name: "Rubik-SemiBold", size: 36)
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Blue")
        view.layer.cornerRadius = 30
        return view
    }()
    
    let wordTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Programming."
        label.font = UIFont(name: "Rubik-Bold", size: 24)
        return label
    }()
    
    let partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "noun"
        label.font = UIFont(name: "Rubik-Italic", size: 14)
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "creating a sequence of instructions to enable the computer to do something"
        label.font = UIFont(name: "Rubik-Light", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Light Gray")
        setupUI()
    }
    
    func setupUI() {
        setupAppTitle()
        setupContainerView()
        setupWordTitle()
        setupParsOfSpeech()
        setupDefinition()
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
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 30),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
        ])
    }
    
    func setupWordTitle() {
        containerView.addSubview(wordTitleLabel)
        NSLayoutConstraint.activate([
            wordTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            wordTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
        ])
    }
    
    func setupParsOfSpeech() {
        containerView.addSubview(partsOfSpeechLabel)
        NSLayoutConstraint.activate([
            partsOfSpeechLabel.bottomAnchor.constraint(equalTo: wordTitleLabel.bottomAnchor, constant: -4),
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.trailingAnchor, constant: 5),
            partsOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor),
        ])
    }
    
    func setupDefinition() {
        containerView.addSubview(definitionLabel)
        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: wordTitleLabel.bottomAnchor, constant: 20),
            definitionLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }


}

