//
//  RandomWordButton.swift
//  Werdd
//
//  Created by Chris Forbes on 9/7/23.
//

import UIKit

class RandomWordButton: UIButton {
    
    var completion: (() -> Void)?
    
    init(frame: CGRect, completion: (() -> Void)?) {
        self.completion = completion
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        tintColor = .white
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "arrow.triangle.2.circlepath.circle", withConfiguration: symbolConfiguration)
        setImage(image, for: .normal)
        
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        completion?()
    }
}
