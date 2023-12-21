//
//  NetworkManager.swift
//  Werdd
//
//  Created by Chris Forbes on 12/20/23.
//

import Foundation

final class NetworkManager {
    func fetchRandomWord(completion: @escaping (Result<Word, Error>) -> Void) {
        guard let randomWordsURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words?random=true&hasDetails=definitions") else {
            print("An error occurred")
            return
        }
        
        let headers = [
            "x-rapidapi-key": APIConstants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: randomWordsURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Fetching random word failed with error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let randomWord = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(randomWord))
            } catch {
                print("Failed to decode random word with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchSpecificWord(_ word: String, completion: @escaping (Result<Word, Error>) -> Void) {
        guard let specificWordURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(word)") else {
            print("An error occurred finding word: \(word)")
            return
        }
        
        let headers = [
            "x-rapidapi-key": APIConstants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: specificWordURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Fetching specific word failed with error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let randomWord = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(randomWord))
            } catch {
                print("Failed to decode specific word with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
