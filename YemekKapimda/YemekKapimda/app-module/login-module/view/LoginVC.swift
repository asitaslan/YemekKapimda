//
//  LoginVC.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 16.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var kullaniciAdiTextIntput: UITextField!
    @IBOutlet weak var loginButtonUI: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButtonUI.layer.cornerRadius = 10
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(kullaniciAdiTextIntput.text, forKey: "username")
        if kullaniciAdiTextIntput.text != "" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Giriş Başarısız", message: "Lütfen Kullanıcı Adınızı giriniz", preferredStyle: .alert)
            self.present(alert, animated: true)
            let tamamAction = UIAlertAction(title: "Tamam", style: .cancel) { action in
            }
            alert.addAction(tamamAction)

        }
        print(defaults.object(forKey: "username")!)
    }
    

}
