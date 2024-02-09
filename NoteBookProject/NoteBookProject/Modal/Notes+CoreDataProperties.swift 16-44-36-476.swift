//
//  Notes+CoreDataProperties.swift
//  NoteBookProject
//
//  Created by zoho on 24/01/24.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var notesTitle: String?
    @NSManaged public var notesStatus: Bool
    @NSManaged public var notesDescription: String?
    @NSManaged public var notesDate: Date?

}

extension Notes : Identifiable {

}
