//
//  Register+CoreDataProperties.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/26/22.
//
//

import Foundation
import CoreData


extension Register {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Register> {
        return NSFetchRequest<Register>(entityName: "Register")
    }

    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension Register : Identifiable {

}
