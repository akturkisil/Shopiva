//
//  LoginVC.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 31.01.2021.
//

import UIKit
import Alamofire
import SCLAlertView

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    
        let userEmail = emailTextField.text!
        let userPass = passwordTextField.text!
        if emailTextField.text != "" &&  passwordTextField.text != "" {
                
            let parameters = ["ref": "5380f5dbcc3b1021f93ab24c3a1aac24", "userEmail":userEmail, "userPass":userPass,
                "face": "no"]
            let baseURL = "https://jsonbulut.com/json/userLogin.php"
                
        AF.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
        if (response.response?.statusCode == 200) {
        
        let userLogin = try? JSONDecoder().decode(UserLogin.self, from: response.data!)
        let userID = userLogin?.user[0].bilgiler?.userID
                        
        UserDefaults.standard.setValue(userID, forKey: "userID")
        print("User ID = \(userID)")
                        
        if (userID != nil) {
            let durum = userLogin?.user[0].durum
            if (durum == true) {
        self.performSegue(withIdentifier: "toProductsVC", sender: nil)
        } else {
            SCLAlertView().showTitle(
                "Try Again", // Title of view
                subTitle: "Something went wrong.", timeout: nil,
                completeText: "OK",
                style: .error,
                colorStyle: 0x821e00,
                colorTextButton: 0xFFFFFF
            )
        }
                        
        } else {
            SCLAlertView().showTitle(
                "Oops!", // Title of view
                subTitle: "Something went wrong.", timeout: nil,
                completeText: "OK",
                style: .error,
                colorStyle: 0x821e00,
                colorTextButton: 0xFFFFFF
            )                     }
                }
        }
        } else {
            SCLAlertView().showTitle(
                "Oops!", // Title of view
                subTitle: "Something went wrong.", timeout: nil,
                completeText: "OK",
                style: .error,
                colorStyle: 0x821e00,
                colorTextButton: 0xFFFFFF
            )             }
        }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
        
       
