//
//  ProductDetailVC.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 31.01.2021.
//

import UIKit
import SCLAlertView
import Alamofire

class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
   // @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailLabel: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var selectedProduct: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedProduct!.productName
        detailLabel.text = selectedProduct!.description
        priceLabel.text = "\(selectedProduct!.price) ₺"
        let url = URL(string: selectedProduct!.images[0].normal)!
        let data = try! Data(contentsOf: url)
        detailImage.image = UIImage(data: data)
    }
    
    @IBAction func btnAddtoCart(_ sender: UIButton) {
        let baseURL = "http://jsonbulut.com/json/orderForm.php"
        let refCode = "5380f5dbcc3b1021f93ab24c3a1aac24"
        
        let parameters = ["ref": refCode, "customerId": UserDefaults.standard.string(forKey: "userID"), "productId": selectedProduct!.productId, "html": selectedProduct!.productId]
        AF.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
            }
            
        }
        SCLAlertView().showTitle(
            "Success",
            subTitle: "Product added to cart!", timeout: nil,
            completeText: "OK",
            style: .success,
            colorStyle: 0x1a5e08,
            colorTextButton: 0xFFFFFF
        )
    }
}










