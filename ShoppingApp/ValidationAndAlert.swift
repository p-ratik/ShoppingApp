//
//  ValidationAndAlert.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/23/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Validation Functions starts
    
    //FUNCTION: To validate Email
    func validateEmail(email: String) -> Bool {
        if(email.isEmpty) {
            return false
        }
        else {
            let emailRegExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,63}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegExpression)
            return emailPredicate.evaluate(with: email)
            
        }
    }
    
    //FUNCTION: To validate UserName
    func userNameValidation(userName: String) -> Bool {
        let nameRegExpression = "^(?=.*[a-zA-z_]).{4,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegExpression)
        return namePredicate.evaluate(with: userName)
    }
    
    
    //FUNCTION: To Check Empty Password
    func checkPasswordEmpty(password: String) -> Bool {
        return password.isEmpty
    }
    
    
    //FUNCTION: To check password Length
    func checkPasswordLength(password: String) -> Bool {
        return password.count < 6
    }
    
    
    //FUNCTION: To validate Password
    func validatePassword(password: String) -> Bool {
        let passwordRegExpression = "^(?=.*[a-zA-Z.!@#$%&*|\\+-])(?=.*[0-9]).{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegExpression)
        return passwordPredicate.evaluate(with: password)
    }
    
    
    //FUNCTION: To check whether passwords and Confirm Password Matches
    func validateConfirmPassword(password: String, confirmPasword: String) -> Bool {
        return password == confirmPasword
    }
    
    //FUNCTION: To validate Mobile No
    func validateMobile(mobile: String) -> Bool {
        if(mobile.isEmpty) {
            return false
        }
        else {
            let mobileRegExpression = "^(?=.*[0-9]).{10}$"
            let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegExpression)
            return mobilePredicate.evaluate(with: mobile)
        }
    }
    
    
    //FUNCTION: To Show Alert
    func showAlert(title: String? = "Alert" ,message: String) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    //FUNCTION: To show placed alert
    func showOrderPlacedAlert(itemName: String, mssg: String, title: String) {
        let alert = UIAlertController(title: title, message: itemName + "-" + mssg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) {
            _ in
            let notificationViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            notificationViewController.itemPlacedName = itemName
            self.navigationController?.pushViewController(notificationViewController, animated: true)
        })
        self.present(alert, animated: true)
    }
    
    // MARK: - Validation Functions ends
}
