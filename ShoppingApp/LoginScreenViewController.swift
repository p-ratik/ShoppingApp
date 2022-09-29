//
//  LoginScreenViewController.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/24/22.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

class LoginScreenViewController: UIViewController {

    // MARK: - IBOutlets for Login Page starts
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    // MARK: - IBOutlets for Login Page ends
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.authenticateByUserTouchID()
        self.authenticateUserByFaceTouchID()
        
        //Creating the Imageview for Background Image
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "background.jpg")
        backgroundImageView.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
        
        loginImageView.layer.cornerRadius = loginImageView.frame.size.width/2
        loginImageView.clipsToBounds = true
        loginImageView.image = UIImage(named: "shopLogo.jpg")
        
        // Setting Properties and Imageview Icons to Textfields
        let emailImageView = UIImageView()
        let passwordImageView = UIImageView()
        let emailIcon = UIImage(named: "email.png")
        let passwordIcon = UIImage(named: "password.png")
        emailImageView.image = emailIcon
        passwordImageView.image = passwordIcon
        loginPasswordTextField.leftViewMode = .always
        loginEmailTextField.leftViewMode = .always
        
        loginEmailTextField.leftView = emailImageView
        loginPasswordTextField.leftView = passwordImageView
        
        loginEmailTextField.layer.borderWidth = 0.2
        loginEmailTextField.layer.cornerRadius = 9
        loginPasswordTextField.layer.borderWidth = 0.2
        loginPasswordTextField.layer.cornerRadius = 9
        
    }
    
    // MARK: - IBAction for Login Page starts
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        let email = loginEmailTextField.text!
        let password = loginPasswordTextField.text!
        
        if(email.isEmpty && password.isEmpty) {
            self.showAlert(message: "Please Enter Email and Password")
        }
        else if(self.validateEmail(email: email)) {
            if(self.checkPasswordEmpty(password: password)) {
                self.showAlert(message: "Please Enter Password!")
            }
            else {
                // Firebase Authentication for login
                Auth.auth().signIn(withEmail: email, password: password, completion: {
                    (response,error) in
                    if let error = error {
                        let err = error as NSError
                            switch err.code {
                                case AuthErrorCode.wrongPassword.rawValue:
                                    self.showAlert(message: "Wrong Password!")
                                    
                                case AuthErrorCode.userNotFound.rawValue:
                                    self.showAlert(message: "User does not exists! Please signUp")
                                    
                                default:
                                    self.showAlert(message: err.localizedDescription)
                                }
                    }
                    else {
                        print("User Logged In Succesfully!!")
                        //saving data into keychain
                        let pwdData = Data(password.utf8)
                        let saveDataStatus = KeychainServices.saveDataIntoKeychain(key: email, data: pwdData)
                        print(saveDataStatus)
                        
                        //fetch data from keychain
                        if let receivedData = KeychainServices.getDataFromKeychain(key: email) {
                            let result = String(decoding: receivedData, as: UTF8.self)
                            print(result)
                        }
                        let mainTabViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! UITabBarController
                        self.navigationController?.pushViewController(mainTabViewController, animated: true)
                    }
                })
            }
        }
        else {
            self.showAlert(message: "Please Enter valid Email")
        }
    }
    // MARK: - IBAction for Login Page ends
    
    // Touch Id Authentication function
    func authenticateByUserTouchID() {
        let context: LAContext = LAContext()
        let reasonStr = "Authentication is required to access the app"
        
        var authError : NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonStr, reply: {
                success, arror in
                if success{
                    print("User Authenticaton successfully")
                }
                else{
                    if let error = authError {
                        let message = self.showmessageWithErrorCode(errorcode: error as! Int)
                        print(message)
                    }
                }
            })
        }
    }
    
    // Error Display function
    func showmessageWithErrorCode(errorcode: Int) -> String {
        var msg = ""
        switch errorcode {
        case LAError.appCancel.rawValue:
            msg = "Authentication was cancelled by the application"
        
        case LAError.authenticationFailed.rawValue:
            msg = "Unable to autenticate"
        default :
            msg = "common error"
        }
        
        return msg
    }
    
    // Face Id Authentication function
    func authenticateUserByFaceTouchID() {
           let context = LAContext()
           var error: NSError?
           let reason = "Identify yourself"
           
           if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
               
               context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                   [weak self] success, authenticationError in
                   
                   if success {
                       DispatchQueue.main.async {
                           self?.showAlert(title: "Success", message: "Authenticated succesfully")
                       }
                      
                   }
                   else {
                       print("Non Matching")
                       exit(0)
                   }
               }
           }
           else {
               self.showAlert(title: "Error", message: "No biometric authentication available")
           }
       }

}
