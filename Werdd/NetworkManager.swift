//
//  NetworkManager.swift
//  Werdd
//
//  Created by Chris Forbes on 12/20/23.
//

import Foundation
import Alamofire

final class NetworkManager {
    func fetchRandomWord() async throws -> Word {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": APIConstants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        do {
            let word = try await AF.request("https://wordsapiv1.p.rapidapi.com/words?random=true&hasDetails=definitions",
                                             method: .get,
                                             headers: headers)
                .serializingDecodable(Word.self)
                .value
            return word
        } catch {
            print("Fetching random word failed with error: \(String(describing: error.localizedDescription))")
            throw error
        }
    }
    
    func fetchSpecificWord(_ word: String) async throws -> Word {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": APIConstants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        do {
            let word = try await AF.request("https://wordsapiv1.p.rapidapi.com/words/\(word)", method: .get, headers: headers)
                .serializingDecodable(Word.self)
                .value
            return word
        } catch {
            print("Fetching specific word failed with error: \(String(describing: error.localizedDescription))")
            throw error
        }
    }
}
