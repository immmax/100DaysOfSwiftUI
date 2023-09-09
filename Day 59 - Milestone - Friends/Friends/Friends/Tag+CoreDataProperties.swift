//
//  Tag+CoreDataProperties.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/18/23.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tagName: String?
    @NSManaged public var user: NSSet?

    public var wrappedTagName: String {
        tagName ?? "Unknown Tag"
    }
}

// MARK: Generated accessors for user
extension Tag {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CachedUser)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CachedUser)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension Tag : Identifiable {

}
