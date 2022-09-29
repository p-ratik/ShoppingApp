//
//  File.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/27/22.
//
import Foundation
import Security

class KeychainServices: NSObject {
    class func saveDataIntoKeychain(key: String, data: Data) -> OSStatus {
        let query = [kSecClass as String: kSecClassGenericPassword,
                     kSecAttrAccount as String: key,
                     kSecValueData as String: data] as [String: Any]
        //delete keychain item
        SecItemDelete(query as CFDictionary)
        //Add new item into key chain
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    class func getDataFromKeychain(key: String) -> Data? {
        let query = [kSecClass as String: kSecClassGenericPassword,
                     kSecAttrAccount as String: key,
                     kSecReturnData as String: kCFBooleanTrue!,
                     kSecMatchLimit as String: kSecMatchLimitOne] as [String: Any]
        //Search for Keychain item
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return dataTypeRef as! Data?
        }
        else {
            return nil
        }
    }
}

