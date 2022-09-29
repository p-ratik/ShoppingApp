//
//  DBOperations.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/22/22.
//

import Foundation
import CoreData
import UIKit

class DBOperations {
    
    //Creating shared Instance
    static var sharedInstance = DBOperations()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    // MARK: - Functions for Datbase CRUD starts
    
    //function to save the data into cart
    func saveDataIntoCart(object: [String: String]) -> Bool {
        let cart = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context!) as! Cart
        //Storing values
        cart.id = object["id"]
        cart.itemTitle = object["itemTitle"]
        cart.itemDescription = object["itemDescription"]
        cart.itemImageURL = object["itemImageURL"]
        cart.status = object["status"]
        do {
            try context?.save()
            return true
        }
        catch {
            print("Data Not Inserted Into Cart")
        }
        return false
    }
    
    //function to save the data into Register
    func saveDataIntoRegister(object: [String: String]) -> Bool {
        let register = NSEntityDescription.insertNewObject(forEntityName: "Register", into: context!) as! Register
        //Storing values
        register.username = object["username"]
        register.email = object["email"]
        register.mobile = object["mobile"]
        register.password = object["password"]
        do {
            try context?.save()
            return true
        }
        catch {
            print("Data Not Inserted Into Register")
        }
        return false
    }
    
    
    //function to retrieve the data from Cart Entity
    func getDataFromCart() -> [Cart] {
        var cart = [Cart]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        do {
            cart = try context?.fetch(fetchRequest) as! [Cart]
        }
        catch {
            print("Cannot get Data from Cart")
        }
        return cart
    }
    
    //Function to get data from Cart which is not placed
    func getDataFromCartNotPlaced() -> [Cart] {
        var cart = [Cart]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        fetchRequest.predicate = NSPredicate(format: "status = %@","Not Placed")
        do {
            cart = try context?.fetch(fetchRequest) as! [Cart]
        }
        catch {
            print("Cannot get Data from Cart which is not placed")
        }
        return cart
    }

    //Function to update the data from Cart
    func updateDataFromCart(index: Int) -> Bool {
        let cart = getDataFromCart()
        cart[index].status = "Placed"
        do {
            try context?.save()
            print("Data Updated Successfully!")
            return true
        }
        catch {
            print("Data Not updated from cart")
        }
        return false
    }

    //function to check username is present or not in database
    func isUsernamePresent(username: String) -> Bool {
        var register = [Register]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Register")
        fetchRequest.predicate = NSPredicate(format: "username = %@", username)
        do {
            register = try context?.fetch(fetchRequest) as! [Register]
            if(register.count == 1) {
                return true
            }
        }
        catch {
            print("Error in Username existence checking")
        }
        return false
    }
    
    // MARK: - Functions for Datbase CRUD ends
}
