//
//  ProductsVC.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 31.01.2021.
//

import UIKit
import Alamofire
import SCLAlertView

class ProductsVC: UITableViewController {
    
    var products: [Product] = []
    
    @IBOutlet weak var loadProducts: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProducts.startAnimating()
        let baseURL = "https://jsonbulut.com/json/product.php"
        let parameters = ["ref": "5380f5dbcc3b1021f93ab24c3a1aac24",
                          "start": "0"]
        
        AF.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                
                let productResponse = try? JSONDecoder().decode(ProductsResponse.self, from: response.data!)
                let durum = productResponse?.Products[0].durum
                if (durum == true) {
                    self.products = (productResponse?.Products[0].bilgiler)!
                    self.tableView.reloadData()
                    self.loadProducts.stopAnimating()
                    self.loadProducts.alpha = 0
                    self.loadProducts.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                } else {
                    SCLAlertView().showTitle(
                        "Oops!", // Title of view
                        subTitle: "Something went wrong.", timeout: nil,
                        completeText: "OK",
                        style: .error,
                        colorStyle: 0x821e00,
                        colorTextButton: 0xFFFFFF
                    )                }
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductsCell
        cell.productNameLabel.text = products[indexPath.row].productName
        cell.productPriceLabel.text = "\(products[indexPath.row].price) ₺"
        let url = URL(string: products[indexPath.row].images[0].normal)!
        let data = try! Data(contentsOf: url)
        cell.productImageView.image = UIImage(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "toProductDetailVC", sender: selectedProduct)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductDetailVC" {
            let destinationVC = segue.destination as! ProductDetailVC
            destinationVC.selectedProduct = (sender as! Product)
        }
    }
}
