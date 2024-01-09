//
//  NetworkManager.swift
//  Werdd
//
//  Created by Chris Forbes on 12/20/23.
//

import Foundation
import Alamofire

final class NetworkManager {
    func fetchRandomWord(completion: @escaping (Result<Word, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": APIConstants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        AF.request("https://wordsapiv1.p.rapidapi.com/words?random=true&hasDetails=definitions", method: .get, headers: headers)
            .responseDecodable(of: Word.self) { response in
                if let error = response.error {
                    print("Fetching random word failed with error: \(String(describing: error.localizedDescription))")
                    completion(.failure(error))
                }
                completion(.success(response.value!))
        }
    }
    
    func fetchSpecificWord(_ word: String, completion: @escaping (Result<Word, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": APIConstants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        AF.request("https://wordsapiv1.p.rapidapi.com/words/\(word)", method: .get, headers: headers)
            .responseDecodable(of: Word.self) { response in
                if let error = response.error {
                    print("Fetching specific word failed with error: \(String(describing: error.localizedDescription))")
                    completion(.failure(error))
                }
                completion(.success(response.value!))
        }
    }
}
