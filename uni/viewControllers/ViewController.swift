//
//  ViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/1/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//


import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var logInLbl: UILabel!
    @IBOutlet weak var schoolEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var login_butlab: UILabel!
    @IBOutlet weak var signup_butlab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupFields(){
        Utilities.styleTextField(logInLbl)
        Utilities.styleTextField(login_butlab)
        Utilities.styleTextField(signup_butlab)
        //Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton_1(logInBtn)
        Utilities.styleFilledButton_1(signUpBtn)
    }
    
    func checkEmptyFields() -> String? {
        
        //Check if fields are empty
        if schoolEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please enter all fields!"
        }
        return nil
    }
    
    
    @IBAction func logInAction(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        let errorMessage = checkEmptyFields()
        if errorMessage != nil{
            ProgressHUD.showError(errorMessage!)
        }
        else{
            
            let processedSchoolEmail = schoolEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let processedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                Auth.auth().signIn(withEmail: processedSchoolEmail, password: processedPassword) { (result, error) in
                    
                    if error != nil{
                        ProgressHUD.showError(error!.localizedDescription)
                    }
                    else{
                        if Auth.auth().currentUser!.isEmailVerified{
                            ProgressHUD.dismiss()
                            self.transToHome()
                        }
                        else{
                            ProgressHUD.dismiss()
                            ProgressHUD.showError("Email not registered!")
                            Auth.auth().currentUser?.delete(completion: { (error) in
                                
                            })
                        }
                        
                    }
                }
        }
    }
    
    func transToHome(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: Constants.StoryBoard.mainTabBarController)
        
        view.window?.rootViewController = homeVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.7
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in
            
        }

    }
    
}

