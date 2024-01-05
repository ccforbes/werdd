//
//  FavoriteWord+CoreDataProperties.swift
//  Werdd
//
//  Created by Chris Forbes on 1/4/24.
//
//

import Foundation
import CoreData


extension FavoriteWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteWord> {
        return NSFetchRequest<FavoriteWord>(entityName: "FavoriteWord")
    }

    @NSManaged public var name: String
    @NSManaged public var definition: String
    @NSManaged public var partOfSpeech: String
    @NSManaged public var isFavorited: Bool
    @NSManaged public var synonyms: [String]?
    @NSManaged public var antonyms: [String]?
    @NSManaged public var examples: [String]?

}

extension FavoriteWord : Identifiable {

}
