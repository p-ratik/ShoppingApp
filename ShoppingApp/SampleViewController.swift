//
//  SampleViewController.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 8/18/22.
//

import UIKit

class SampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        let tb = self.storyboard?.instantiateViewController(withIdentifier: "CustomTab") as! UITabBarController
        self.navigationController?.pushViewController(tb, animated: true)
    
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
