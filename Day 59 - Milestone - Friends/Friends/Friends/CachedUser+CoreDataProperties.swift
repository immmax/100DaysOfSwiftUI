//
//  CachedUser+CoreDataProperties.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/18/23.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var friend: NSSet?
    @NSManaged public var tags: NSSet?

    public var wrappedId: String {
        id ?? "Unknown ID"
    }
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    public var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    public var wrappedAbout: String {
        about ?? "Unknown About Info"
    }
    public var wrappedRegistered: String {
        registered ?? "Unknown Registered Date"
    }

    public var friendArray: [CachedFriend] {
        let set = friend as? Set<CachedFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var tagsArray: [Tag] {
        
        let set = tags as? Set<Tag> ?? []
        
        return set.sorted {
            $0.wrappedTagName < $1.wrappedTagName
        }
    }
}

// MARK: Generated accessors for friend
extension CachedUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CachedFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CachedFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension CachedUser {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
