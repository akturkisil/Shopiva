//
//  ViewController.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 31.01.2021.
//

import UIKit
import Lottie

class SplashScreenVC: UIViewController {
    
    let animation = Animation.named("splash")
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.frame = CGRect(x: 143, y: 400, width: 150, height: 150)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
        self.performSegue(withIdentifier: "dashboard", sender: nil)
        }
    }
}

