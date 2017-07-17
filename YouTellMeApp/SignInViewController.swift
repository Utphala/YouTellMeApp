//
//  SignInViewController.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/17/17.
//  Copyright © 2017 Utphala. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var usernameBox: UITextField!
    @IBOutlet weak var passwordBox: UITextField!
    
    
    
    @IBAction func signinPressed(_ sender: Any) {
        print("SignIn pressed!")
        BackendServiceClient().login(username: usernameBox.text!, password: passwordBox.text!, notificationCallback: {isSuccess in
            print("Callback from Service response: Login success? \(isSuccess)")
            if isSuccess {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "signin", sender: "")
                }
            } else {
                // Do nothing- maybe show alertbox?
                DispatchQueue.main.async {
                    self.showInputDialog()
                }

            }
        })
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Signin failed!", message: "Please check login details and retry", preferredStyle: .alert)
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
}
