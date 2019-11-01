//
//  RegisterVC.swift
//  Artable
//
//  Created by Ivan Kalachev on 1.11.19.
//  Copyright © 2019 Ivan Kalachev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var passwordImgCheck: UIImageView!
    @IBOutlet weak var confirmPasswordImgCheck: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let passTxt = passwordTextField.text else { return }
        
        if textField == confirmPassText {
            passwordImgCheck.isHidden = false
            confirmPasswordImgCheck.isHidden = false
        } else {
            if passTxt.isEmpty {
                passwordImgCheck.isHidden = true
                confirmPasswordImgCheck.isHidden = true
                confirmPassText.text = ""
            }
        }
        
        // Make it so when the passwords match the checkmarks turn to green
        if passwordTextField.text == confirmPassText.text {
            passwordImgCheck.image = UIImage(named: AppImages.GreenCheck)
            confirmPasswordImgCheck.image = UIImage(named: AppImages.GreenCheck)
        } else {
            passwordImgCheck.image = UIImage(named: AppImages.RedCheck)
            confirmPasswordImgCheck.image = UIImage(named: AppImages.RedCheck)
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        guard let email = emailTextField.text, email.isNotEmpty,
            let username = usernameTextField.text, username.isNotEmpty,
            let password = passwordTextField.text, password.isNotEmpty else { return }
        
        spinner.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { (authUser, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            
            self.spinner.stopAnimating()
        }
    }
}
