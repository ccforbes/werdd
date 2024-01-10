//
//  HomeViewModel.swift
//  Werdd
//
//  Created by Chris Forbes on 1/8/24.
//

import Foundation
import UIKit

final class HomeViewModel {
    private let networkManager: NetworkManager
    let appTitle = "Werdd."
    let appTitleFont = UIFont(name: "Rubik-SemiBold", size: 36)
    let backgroundColor = UIColor(named: "Light Gray")
    let favoriteListButtonColor = UIColor(named: "WerddPink")
    
    private var randomWord: Word?
    private var specificWord: Word?
    
    var selectedWord: String? {
        specificWord?.word
    }
    
    var wordDetails: [WordDetail]? {
        specificWord?.results
    }
    
    var randomWordName: String? {
        randomWord?.word
    }
    
    var randomWordDefinition: String? {
        randomWord?.results?.first?.definition
    }
    
    var randomWordPartOfSpeech: String? {
        randomWord?.results?.first?.partOfSpeech
    }
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func refreshRandomWord() async throws {
        let randomWord = try await networkManager.fetchRandomWord()
        self.randomWord = randomWord
    }
    
    func fetchSpecificWord(word: String) async throws {
        let specificWord = try await networkManager.fetchSpecificWord(word)
        self.specificWord = specificWord
    }
    
}
