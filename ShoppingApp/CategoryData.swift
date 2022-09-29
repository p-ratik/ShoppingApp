//
//  CategoryData.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 9/21/22.
//

import Foundation
import Alamofire

class CategoryData {
    
    static var arr: NSArray = []
    static func webService() {
        Alamofire.request("https://dummyjson.com/products/categories/", method: .post, encoding: URLEncoding.default, headers: nil).responseJSON {
                response in
            switch response.result {
            case .success:
                if let isSuccess: NSArray = response.value as! NSArray? {
                    arr = isSuccess
                    print(arr)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
