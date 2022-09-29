//
//  NotificationViewController.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/23/22.
//

import UIKit
import CustomNotificationFramework

class NotificationViewController: UIViewController {

    var itemPlacedName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            let mainTabViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! UITabBarController
            self.navigationController?.pushViewController(mainTabViewController, animated: true)
        }
    }
    
    // MARK: - IBAction For Notification starts
    @IBAction func ButtonClicked(_ sender: Any) {
        let mainTabViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! UITabBarController
        self.navigationController?.pushViewController(mainTabViewController, animated: true)
    }

    @IBAction func notificationButtonClicked(_ sender: Any) {
        let localNotificationObj = LocalNotificationClass()
        localNotificationObj.receiveNotification(itemName: itemPlacedName)
    }
    // MARK: - IBAction For Notification ends

}
