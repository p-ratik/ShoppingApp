//
//  ViewController.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 8/9/22.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        emailTextfield.layer.cornerRadius = 10.0
        emailTextfield.layer.borderWidth = 0.1
        
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.layer.borderWidth = 0.1
        // Do any additional setup after loading the view.
        
    }

    // Connecting Button to next View Controller
    
    /*@IBAction func submitButtonClicked(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }*/
    
    // Action to come to previous page using segue
    @IBAction func comeToPreviousController(_segue: UIStoryboardSegue){
        
    }
    
    // Passing Data from firstViewcontroller to secondViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstViewIdentifier"{
            let secondViewController = segue.destination as! SecondViewController
            let email = emailTextfield.text!
            secondViewController.emailId = email
        }
    }
    
}

