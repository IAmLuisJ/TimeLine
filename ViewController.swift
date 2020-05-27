/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {
    
    //declare variables
    var signupMode = true
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    @IBOutlet var emailTextField: UITextField!

    @IBOutlet var SignUpOrLoginBtn: UIButton!
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signupOrLogin(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == ""
        {
            createAlert(title: "Error in Form", message: "Please enter an email and password")
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            //sign up
            if signupMode {
                let user = PFUser()
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        var displayErrorMessage = "Please try again later."
                        
                        if let error = error as? NSError {
                            let errorString = error.userInfo["error"] as? String
                            displayErrorMessage = errorString ?? "Try again later"
                        }
                        
                        self.createAlert(title: "Error in form", message: displayErrorMessage)
                    } else {
                        print("Sign Up Complete")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        
                    }
                })
                
            } else {
                //login mode
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        var displayErrorMessage = "Please try again later."
                        
                        if let error = error as? NSError {
                            let errorString = error.userInfo["error"] as? String
                            displayErrorMessage = errorString ?? "Try again later"
                        }
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                    } else {
                        
                        print("Sign In Complete")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }

                
                    
                })
                
            }
            
        }
        
        
    }
    

    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var messagLabel: UILabel!
    
    //if user is logged in
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            performSegue(withIdentifier: "showUserTable", sender: self)
            
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func changeSignupMode(_ sender: Any) {
        if signupMode {
            //change to login mode
             //SignUpOrLoginBtn.setTitle("Log In", for: [])
            SignUpOrLoginBtn.setImage(#imageLiteral(resourceName: "Login 3.png"), for: [])
        

            changeSignUpModeButton.setImage(#imageLiteral(resourceName: "btn_user.png"), for: [])
            
            messagLabel.text = "Don't have an account?"
            
            signupMode = false
        } else {
            //change to sign up mode
           SignUpOrLoginBtn.setImage(#imageLiteral(resourceName: "btn_user.png"), for: [])
            
            
            changeSignUpModeButton.setImage(#imageLiteral(resourceName: "Login 3.png"), for: [])
            
            messagLabel.text = "Already have an account?"
            
            signupMode = true
            
        }
        
    }
    
    @IBOutlet var changeSignUpModeButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
