//
//  CartViewController.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 9/22/22.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     // MARK: - IBOutlets for CartViewController starts
     @IBOutlet weak var cartTableView: UITableView!
     
     // MARK: - IBOutlets for CartViewController ends
     
     var cartItems = [Cart]()
     
    //MARK: - CartTableView Datasource methods starts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell" , for: indexPath) as! CategoryTableViewCell
        cell.cartItemTitle?.text = cartItems[indexPath.row].itemTitle
        cell.cartItemImageView.loadImage(tempUrl: cartItems[indexPath.row].itemImageURL!)
        cell.cartItemDescription?.text = cartItems[indexPath.row].itemDescription
        cell.placeOrderButton.tag = indexPath.row
        cell.placeOrderButton.addTarget(self, action: #selector(goToPlaceOrderScreen), for: .touchUpInside)
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
     }
     // MARK: - CartTableView Datasource methods ends
    
    // Objective-C function for navigating to place order screen
    @objc func goToPlaceOrderScreen(_ sender: UIButton) {
         let indexP = IndexPath(row: sender.tag, section: 0)
         let checkoutViewController = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
         checkoutViewController.itemName = cartItems[indexP.row].itemTitle!
         checkoutViewController.rowNumber = cartItems[indexP.row].id
         self.navigationController?.pushViewController(checkoutViewController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.tabBarController?.navigationItem.title = "Cart"
         cartItems = DBOperations.sharedInstance.getDataFromCartNotPlaced()
         cartTableView.reloadData()
    }

}
