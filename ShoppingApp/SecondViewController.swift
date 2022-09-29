//
//  secondViewController.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 8/9/22.
//

import UIKit

class SecondViewController: UIViewController {

    var emailId: String = ""
    @IBOutlet weak var emailFromFirstView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Welcome"
        //self.navigationItem.hidesBackButton = true
        
        emailFromFirstView.text = emailId
        
    }
    
    

   

}
