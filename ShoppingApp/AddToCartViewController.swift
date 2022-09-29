//
//  DetailsViewController.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 9/21/22.
//


import UIKit
import Alamofire

class AddToCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - addToCartTableView DataSource Method Starts
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addToCartTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell" , for: indexPath) as! CategoryTableViewCell
        cell.titleLabel?.text = titleArr[indexPath.row]
        cell.customImageView.loadImage(tempUrl: imageArr[indexPath.row])
        cell.descriptionLabel?.text = descriptionArr[indexPath.row]
        cell.carButton.tag = indexPath.row
        cell.carButton.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // MARK: - addToCartTableView DataSource Method ends
    
    @objc func addItemToCart(_ sender: UIButton) {
        let indexP = IndexPath(row: sender.tag, section: 0)
        let title = titleArr[indexP.row]
        let description = descriptionArr[indexP.row]
        let imageUrl = imageArr[indexP.row]
        
        let dict = ["id": String(count), "itemTitle": title, "itemDescription": description, "itemImageURL": imageUrl, "status": "Not Placed"]
        if(DBOperations.sharedInstance.saveDataIntoCart(object: dict)) {
            print("Data Added into Cart Succesfully")
            count += 1
            self.showAlert(title: "Successful!", message: "Item Added to Cart")
        }
        else {
            print("Error in adding data to cart")
        }
        
        
    }

    @IBOutlet weak var addToCartTableView: UITableView!
    
    var category: String = ""
    var tempUrl: String = "https://dummyjson.com/products/category/"
    
    var titleArr = [String]()
    var descriptionArr = [String]()
    var imageArr = [String]()
    var count: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addToCartTableView.delegate = self
        self.addToCartTableView.dataSource = self
        count = DBOperations.sharedInstance.getDataFromCart().count
        let url: String = tempUrl + category + "/"
        
        Alamofire.request(url , method: .post, encoding: URLEncoding.default, headers: nil).responseJSON {
                response in
            switch response.result {
            case .success:
                if let data: [String: Any] = response.value as! [String: Any]? {
                    let arr = data["products"] as! NSArray
                    for dict in arr {
                        let d = dict as! NSDictionary
                        self.titleArr.append(d["title"] as! String)
                        self.descriptionArr.append(d["description"] as! String)
                        self.imageArr.append(d["thumbnail"] as! String)
                    }
                }
                self.addToCartTableView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
        }
    }

}
extension UIImageView {
    func loadImage(tempUrl: String) {
        guard let url = URL(string: tempUrl) else {
            return
        }
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
