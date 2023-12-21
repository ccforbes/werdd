//
//  SearchView.swift
//  Werdd
//
//  Created by Chris Forbes on 12/21/23.
//

import UIKit

protocol SearchDelegate: AnyObject {
    func search(forWord word: String?)
}

class SearchView: UIView {
    
    weak var searchDelegate: SearchDelegate?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Find a word..."
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10.0
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = UIImage(systemName: "magnifyingglass")
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    init(searchDelegate: SearchDelegate?) {
        print("search view")
        super.init(frame: .zero)
        self.searchDelegate = searchDelegate
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setUpViews() {
        backgroundColor = .white
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(searchButton)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            searchButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func searchButtonPressed() {
        print("Search button pressed")
        searchDelegate?.search(forWord: textField.text)
    }
}
