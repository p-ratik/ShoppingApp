//
//  Cart+CoreDataProperties.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/26/22.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var itemDescription: String?
    @NSManaged public var itemImageURL: String?
    @NSManaged public var itemTitle: String?
    @NSManaged public var status: String?
    @NSManaged public var id: String?

}

extension Cart : Identifiable {

}
