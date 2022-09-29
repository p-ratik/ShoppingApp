//
//  SignUpViewController.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/25/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets for SignUp Page Starts
    @IBOutlet weak var signUpImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    // MARK: - IBOutlets for SignUp Page Starts
    
    // variables for testing Starts
    var testName: String = ""
    var testEmail: String = ""
    var testMobile: String = ""
    var testPassword: String = ""
    
    lazy var isValidName: Bool = userNameValidation(userName: testName)
    lazy var isValidEmail: Bool = validateEmail(email: testEmail)
    lazy var isValidMobile: Bool = validateMobile(mobile: testMobile)
    lazy var isValidPassword: Bool = validatePassword(password: testPassword)
    // variables for testing Starts
    
    // Function to get View Controller
    static func getVC() -> SignUpViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creating the Imageview for Background Image
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "background.jpg")
        backgroundImageView.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
        
        signUpImageView.layer.cornerRadius = signUpImageView.frame.size.width/2
        signUpImageView.clipsToBounds = true
        signUpImageView.image = UIImage(named: "SignUp.jpeg")
        
        // MARK: - ImageViews for TextField Icons starts
        let usernameImageView = UIImageView()
        let emailImageView = UIImageView()
        let mobileImageView = UIImageView()
        let passwordImageView = UIImageView()
        let confirmPasswordImageView = UIImageView()
        // MARK: - ImageViews for TextField Icons starts
        
        // Setting Images to imageviews
        usernameImageView.image = UIImage(named: "username.png")
        emailImageView.image = UIImage(named: "email.png")
        mobileImageView.image = UIImage(named: "phone.png")
        passwordImageView.image = UIImage(named: "password.png")
        confirmPasswordImageView.image = UIImage(named: "confirmPass.png")
        
        // Settign Properties ti textfields
        usernameTextField.leftViewMode = .always
        signUpEmailTextField.leftViewMode = .always
        mobileTextField.leftViewMode = .always
        passwordTextField.leftViewMode = .always
        confirmPasswordTextField.leftViewMode = .always
        
        usernameTextField.leftView = usernameImageView
        signUpEmailTextField.leftView = emailImageView
        mobileTextField.leftView = mobileImageView
        passwordTextField.leftView = passwordImageView
        confirmPasswordTextField.leftView = confirmPasswordImageView
        
        usernameTextField.layer.borderWidth = 0.2
        usernameTextField.layer.cornerRadius = 9
        signUpEmailTextField.layer.borderWidth = 0.2
        signUpEmailTextField.layer.cornerRadius = 9
        mobileTextField.layer.borderWidth = 0.2
        mobileTextField.layer.cornerRadius = 9
        passwordTextField.layer.borderWidth = 0.2
        passwordTextField.layer.cornerRadius = 9
        confirmPasswordTextField.layer.borderWidth = 0.2
        confirmPasswordTextField.layer.cornerRadius = 9
    }
    
    // MARK: - IBAction for SignUp Page starts
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        let username = usernameTextField.text!
        let emailSignUp = signUpEmailTextField.text!
        let mobile = mobileTextField.text!
        let signUpPassword = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        if(username.isEmpty) {
            self.showAlert(message: "Please fill the Name")
        }
        else if(self.userNameValidation(userName: username)) {
            if(self.validateEmail(email: emailSignUp)) {
                if(self.validateMobile(mobile: mobile)) {
                    if(self.checkPasswordEmpty(password: signUpPassword)) {
                        self.showAlert(message: "Please Enter Password!")
                    }
                    else if(self.checkPasswordLength(password: signUpPassword)) {
                        self.showAlert(message: "Password should be minimum 6 Characters")
                    }
                    else if(self.validatePassword(password: signUpPassword)) {
                        if(self.validateConfirmPassword(password: signUpPassword, confirmPasword: confirmPassword)) {
                            let dict = ["username": username ,"email": emailSignUp ,"mobile": mobile, "password": signUpPassword]
                            
                            if(DBOperations.sharedInstance.isUsernamePresent(username: username)) {
                                self.showAlert(message: "Username is Already taken. Please try Another!")
                            }
                            else {
                                //Saving Into Firebase
                                Auth.auth().createUser(withEmail: emailSignUp, password: signUpPassword, completion: {
                                    (response, error) -> Void in
                                if let error = error {
                                    print(error.localizedDescription)
                                    self.showAlert(title: "Alert", message: "Email Already Exists! Try to Login!")
                                }
                                else {
                                    print("User Signed Up Successfully!")
                                    //adding data into core data
                                    if(DBOperations.sharedInstance.saveDataIntoRegister(object: dict)) {
                                        print("Data Added into Register Succesfully")
                                        //Navigate to tabViewController
                                        let mainTabViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! UITabBarController
                                        self.navigationController?.pushViewController(mainTabViewController, animated: true)
                                    }
                                    else {
                                        print("Error in adding data to Register")
                                    }
                                }
                                })
                            }
                        }
                        else {
                            self.showAlert(message: "Confirm Password Must be same as Password")
                        }
                    }
                    else {
                        self.showAlert(message: "Password must be alphanumeric")
                    }
                }
                else {
                    self.showAlert(message: "Please Enter 10 Digit Valid Mobile Number")
                }
            
            }
            else {
                self.showAlert(message: "Please Enter Valid Email Address")
            }
            
        }
        else {
            self.showAlert(message: "Username should be Minimum 4 Characters")
        }
    
    }
   // MARK: - IBAction for SignUp Page ends

    
    

}
