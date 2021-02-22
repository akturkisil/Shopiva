//
//  MyOrdersVC.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 31.01.2021.
//

import UIKit
import Alamofire

class MyOrdersVC: UITableViewController {
    
    var orderList: [OrderListElement] = []
    
    @IBOutlet weak var loadOrders: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadOrders.startAnimating()
        let baseURL = "https://jsonbulut.com/json/orderList.php"
        let refCode = "5380f5dbcc3b1021f93ab24c3a1aac24"
        
        let parameters = ["ref": refCode, "musterilerID": UserDefaults.standard.string(forKey: "userID")]
        AF.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                
                let userOrderList = try? JSONDecoder().decode(OrderList.self, from: response.data!)
                self.orderList = (userOrderList?.orderList[0])!
                self.tableView.reloadData()
                self.loadOrders.stopAnimating()
                self.loadOrders.alpha = 0
                self.loadOrders.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
        cell.orderNameLabel.text = orderList[indexPath.row].urunAdi
        cell.orderPriceLabel.text = "\(orderList[indexPath.row].fiyat!) ₺"
        let url = URL(string: orderList[indexPath.row].normal)
        let data = try! Data(contentsOf: url!)
        cell.orderImageView.image = UIImage(data: data)
        
        return cell
    }
}
