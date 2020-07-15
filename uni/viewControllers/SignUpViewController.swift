//
//  SignUpViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/1/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupFields(){
//        Utilities.styleTextField(firstNameTextField)
//        Utilities.styleTextField(lastNameTextField)
//        Utilities.styleTextField(schoolEmailTextField)
//        Utilities.styleTextField(passwordTextField)
//        Utilities.styleTextField(confirmPasswordTextField)
    }
    
    func checkError() -> String? {
        let processedFirstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedLastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedSchoolEmail = schoolEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedCPassword = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Check if fields are empty
        if processedFirstName == ""||processedLastName == ""||processedSchoolEmail == ""||processedPassword == ""||processedCPassword == ""{
            return "Please enter all fields!"
        }
        // Check if email is .edu
        if Utilities.isValidEduEmail(schoolEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
            return "Email format incorrect. Please confirm that the email is school affiliated."
        }
        // Check if password's complexity is valid
        if Utilities.isPasswordValid(passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
            return "Please make sure your password is atleast 8 characters long, contains one number, and contains one special character!"
        }
        // Check if both password fields are same
        if confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines){
            return "Please make sure confirmed password matches your password!"
        }
        
        return nil
    }

    @IBAction func nextAction(_ sender: Any) {
        let processedFirstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedLastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedSchoolEmail = schoolEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        let errorMessage = checkError()
        if errorMessage != nil{
            ProgressHUD.showError(errorMessage!)
        }
        else{
            Auth.auth().createUser(withEmail: processedSchoolEmail, password: processedPassword) { (result, error) in
                if error != nil{
                    ProgressHUD.showError(error as? String)
                }
                else{
                    let db = Firestore.firestore()
                    
                    db.collection("Users").document(result!.user.uid).setData(["First Name" : processedFirstName, "Last Name" : processedLastName, "UID" : result!.user.uid, "Current RoomID":"None"]) { (error) in
                        if error != nil{
                            ProgressHUD.showError(error as? String)
                        }
                    }
                    ProgressHUD.dismiss()
                    self.transToEmailVer()
                }
            
            }
                
        }
    }
    func transToEmailVer(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let emailVerVC = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.emailVerificationViewController) as? EmailVerificationViewController
        
        view.window?.rootViewController = emailVerVC
        let options: UIView.AnimationOptions = .transitionFlipFromRight

        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.7
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in
            
        }
        view.window?.makeKeyAndVisible()
    }
}


