//
//  CategoryViewController.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 9/21/22.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets for Caterogy start
    @IBOutlet weak var categoryTableView: UITableView!
    
    // MARK: - IBOutlets for Caterogy end
    
    var categoryArr = [String]()
    
    // MARK: - categoryTableView DataSource methods starts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.nameLabel?.text = categoryArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addToCartViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as! AddToCartViewController
        addToCartViewController.category = categoryArr[indexPath.row]
        self.navigationController?.pushViewController(addToCartViewController, animated: true)
    }
    // MARK: - categoryTableView DataSource methods ends
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        // Getting data from using third party Alamofire
        Alamofire.request("https://dummyjson.com/products/categories/", method: .post, encoding: URLEncoding.default, headers: nil).responseJSON {
                response in
            switch response.result {
            case .success:
                if let data: [String] = response.value as! [String]? {
                    self.categoryArr = data
                }
                self.categoryTableView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Categories"
    }

}
