//
//  DataManager.swift
//  Werdd
//
//  Created by Chris Forbes on 1/4/24.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static var managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - Create
    static func addFavoriteWord(fromWord word: String, withDetails details: WordDetail) {
        let favoriteWord = FavoriteWord(context: managedObjectContext)
        favoriteWord.name = word
        favoriteWord.definition = details.definition
        favoriteWord.partOfSpeech = details.partOfSpeech
        favoriteWord.synonyms = details.synonyms
        favoriteWord.antonyms = details.antonyms
        favoriteWord.examples = details.examples
        favoriteWord.isFavorited = true
        
        do {
            try managedObjectContext.save()
            print("saved")
        } catch {
            print("unable to add favorite word")
        }
    }
    
    // MARK: - Read
    static func fetchAllFavoriteWords(completion: (([FavoriteWord]?) -> Void)) {
        do {
            let favoriteWords = try managedObjectContext.fetch(FavoriteWord.fetchRequest())
            completion(favoriteWords)
        } catch {
            print("Could not fetch favorite words")
            completion(nil)
        }
    }
    
    static func fetchFavoriteWord(withName name: String, andDefinition definition: String, completion: (FavoriteWord?) -> Void) {
        let fetchRequest = FavoriteWord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND definition == %@", name, definition)
        
        do {
            let favoriteWord = try managedObjectContext.fetch(fetchRequest)
            completion(favoriteWord.first)
        } catch {
            print("Could not fetch word")
            completion(nil)
        }
    }
    
    // MARK: - Update
    
    // MARK: - Delete
    
    static func deleteAllFavoriteWords() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteWord")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch {
            print("Could not delete all words")
        }
    }
    
    static func deleteFavoriteWord(withName name: String, withDefinition definition: String) {
        let fetchRequest = FavoriteWord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND definition == %@", name, definition)
        
        do {
            let favoriteWord = try managedObjectContext.fetch(fetchRequest)
            for word in favoriteWord {
                managedObjectContext.delete(word)
            }
        } catch {
            print("Could not delete")
        }
    }
    
    static func deleteFavoriteWord(word: FavoriteWord) throws {
        managedObjectContext.delete(word)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("unable to add favorite word")
        }
    }
}
