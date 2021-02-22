//
//  RegisterVC.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 31.01.2021.
//

import UIKit
import Alamofire
import SCLAlertView

class RegisterVC: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        if firstNameTextField.text != "" && lastNameTextField.text != "" && emailTextField.text != "" && phoneTextField.text != "" && passwordTextField.text != "" {
            
            
        let baseURL = "https://jsonbulut.com/json/userRegister.php"
        let refCode = "5380f5dbcc3b1021f93ab24c3a1aac24"
           
        let parameters = ["ref": refCode,
                        "userName": firstNameTextField.text!,
                        "userSurname": lastNameTextField.text!,
                        "userPhone": phoneTextField.text!,
                        "userMail": emailTextField.text!,
                        "userPass": passwordTextField.text!]
            
    AF.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
    if response.response?.statusCode == 200 {
                    
        let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: response.data!)
    if registerResponse != nil {
                        
        let durum = registerResponse?.user[0].durum
    if (durum == true) {
        let userID = registerResponse!.user[0].kullaniciId
    UserDefaults.standard.setValue(userID, forKey: "userID")
    print("User ID = \(userID)")
                            
    self.performSegue(withIdentifier: "toProductsVC", sender: nil)
    } else {
    print("Girilen bilgiler hatalı!")
    }
                            
    } else {
        SCLAlertView().showTitle(
            "Oops!", // Title of view
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
        )                 }
    }
            
    } else {
        SCLAlertView().showTitle(
            "Oops!", // Title of view
            subTitle: "Something went wrong.", timeout: nil,
            completeText: "OK",
            style: .error,
            colorStyle: 0x821e00,
            colorTextButton: 0xFFFFFF
        )
        
    }
    }
}

