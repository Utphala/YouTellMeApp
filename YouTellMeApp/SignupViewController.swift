//
//  SignupViewController.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/17/17.
//  Copyright © 2017 Utphala. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var phoneNumberBox: UITextField!
    @IBOutlet weak var repasswordBox: UITextField!
    @IBOutlet weak var passwordBox: UITextField!
    @IBOutlet weak var fnameBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupTrigger(_ sender: Any) {
        let email:String = emailBox.text!
        let name:String = fnameBox.text!
        let phoneNum:String = phoneNumberBox.text!
        let password:String = passwordBox.text!
        let repassword:String = repasswordBox.text!
        
        if password == repassword {
            BackendServiceClient().signup(email: email, password: password, fullname: name, callback: { isSuccess in
                if isSuccess {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "signup", sender: "")
                    }
                } else {
                    // Alert
                }
            })
        }
    }
    
}
