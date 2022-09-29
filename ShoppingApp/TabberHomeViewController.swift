//
//  TabberHomeViewController.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 8/10/22.
//

import UIKit

class TabberHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToLoginButtonClicked(_ sender: Any) {
       /* let firstViewController = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        self.navigationController?.pushViewController(firstViewController, animated: true)*/
        
        let sampleViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarControllerIdentifier") as! UITabBarController
        self.navigationController?.pushViewController(sampleViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
