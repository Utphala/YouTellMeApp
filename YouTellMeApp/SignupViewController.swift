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
                    DispatchQueue.main.async {
                        self.showInputDialog(title: "Signup failed!", message: "Please retry again later!")
                    }
                }
            })
        } else {
            self.showInputDialog(title: "Alert \(name)", message: "Hello \(name) password values don't match. Retry!")
        }
    }
    
    func showInputDialog(title titl: String, message msg: String) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: titl, message: msg, preferredStyle: .alert)
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
}
