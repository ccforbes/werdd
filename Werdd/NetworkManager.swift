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
                print(randomWord)
                completion(.success(randomWord))
            } catch {
                print("Failed to decode Word with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
