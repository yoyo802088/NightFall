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
import SVProgressHUD

class SignUpViewController: UIViewController {
    
    
    var welcome_lbl = UILabel()
    var sign_up = UIButton()
    var back_btn = UIButton()
    var email_txtfld = UITextField()
    var password_txtfld = UITextField()
    var confirmPass_txtfld = UITextField()
    var stroke_email = UIView()
    var stroke_password = UIView()
    var stroke_confirmPass = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        
        welcome_lbl.translatesAutoresizingMaskIntoConstraints = false
        welcome_lbl.widthAnchor.constraint(equalToConstant: frame_width*(143/263)).isActive = true
        welcome_lbl.heightAnchor.constraint(equalToConstant: frame_height*(58/348)).isActive = true
        welcome_lbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                             constant: frame_width*(43/263)).isActive = true
        welcome_lbl.topAnchor.constraint(equalTo: self.view.topAnchor,
                                         constant: frame_height*(23/348)).isActive = true
        
        email_txtfld.translatesAutoresizingMaskIntoConstraints = false
        email_txtfld.widthAnchor.constraint(equalToConstant: frame_width*(165/263)).isActive = true
        email_txtfld.heightAnchor.constraint(equalToConstant: frame_height*(23/348)).isActive = true
        email_txtfld.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(104/348)).isActive = true
        email_txtfld.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        
        password_txtfld.translatesAutoresizingMaskIntoConstraints = false
        password_txtfld.widthAnchor.constraint(equalToConstant: frame_width*(165/263)).isActive = true
        password_txtfld.heightAnchor.constraint(equalToConstant: frame_height*(23/348)).isActive = true
        password_txtfld.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(163/348)).isActive = true
        password_txtfld.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        
        confirmPass_txtfld.translatesAutoresizingMaskIntoConstraints = false
        confirmPass_txtfld.widthAnchor.constraint(equalToConstant: frame_width*(165/263)).isActive = true
        confirmPass_txtfld.heightAnchor.constraint(equalToConstant: frame_height*(23/348)).isActive = true
        confirmPass_txtfld.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(222/348)).isActive = true
        confirmPass_txtfld.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        
        stroke_email.translatesAutoresizingMaskIntoConstraints = false
        stroke_email.widthAnchor.constraint(equalToConstant: frame_width*(171/263)).isActive = true
        stroke_email.heightAnchor.constraint(equalToConstant: frame_height*(1/348)).isActive = true
        stroke_email.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(127/348)).isActive = true
        stroke_email.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        
        stroke_password.translatesAutoresizingMaskIntoConstraints = false
        stroke_password.widthAnchor.constraint(equalToConstant: frame_width*(171/263)).isActive = true
        stroke_password.heightAnchor.constraint(equalToConstant: frame_height*(1/348)).isActive = true
        stroke_password.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(186/348)).isActive = true
        stroke_password.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        
        stroke_confirmPass.translatesAutoresizingMaskIntoConstraints = false
        stroke_confirmPass.widthAnchor.constraint(equalToConstant: frame_width*(171/263)).isActive = true
        stroke_confirmPass.heightAnchor.constraint(equalToConstant: frame_height*(1/348)).isActive = true
        stroke_confirmPass.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(245/348)).isActive = true
        stroke_confirmPass.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        
        back_btn.translatesAutoresizingMaskIntoConstraints = false
        back_btn.widthAnchor.constraint(equalToConstant: frame_width*(32/263)).isActive = true
        back_btn.heightAnchor.constraint(equalToConstant: frame_height*(40/348)).isActive = true
        back_btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(288/348)).isActive = true
        back_btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        
        sign_up.translatesAutoresizingMaskIntoConstraints = false
        sign_up.widthAnchor.constraint(equalToConstant: frame_width*(132/263)).isActive = true
        sign_up.heightAnchor.constraint(equalToConstant: frame_height*(40/348)).isActive = true
        sign_up.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(288/348)).isActive = true
        sign_up.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(87/263)).isActive = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func checkError() -> String? {
        
        let processedSchoolEmail = email_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedPassword = password_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedCPassword = confirmPass_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Check if fields are empty
        if processedSchoolEmail == ""||processedPassword == ""||processedCPassword == ""{
            return "Please enter all fields!"
        }
        // Check if email is .edu
//        if Utilities.isValidEduEmail(email_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
//            return "Email format incorrect. Please confirm that the email is school affiliated."
//        }
        // Check if password's complexity is valid
//        if Utilities.isPasswordValid(password_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
//            return "Please make sure your password is atleast 8 characters long, contains one number, and contains one special character!"
//        }
        // Check if both password fields are same
        if confirmPass_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines) != password_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines){
            return "Please make sure confirmed password matches your password!"
        }
        
        return nil
    }

    @objc func signUpAction(_ sender: UIButton!) {
        
        let processedSchoolEmail = email_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let processedPassword = password_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        view.endEditing(true)
        SVProgressHUD.show(withStatus: "Waiting...")
        SVProgressHUD.setDefaultMaskType(.clear)
        let errorMessage = checkError()
        if errorMessage != nil{
            SVProgressHUD.showError(withStatus: errorMessage!)
            SVProgressHUD.dismiss(withDelay: 1.5)
        }
        else{
            Auth.auth().createUser(withEmail: processedSchoolEmail, password: processedPassword) { (result, error) in
                if error != nil{
                    SVProgressHUD.showError(withStatus: error as? String)
                    SVProgressHUD.dismiss(withDelay: 1.5)
                }
                else{
                    let db = Firestore.firestore()
                    
                    db.collection("Users").document(result!.user.uid).setData([ "UID" : result!.user.uid, "Current RoomID":"None"]) { (error) in
                        if error != nil{
                            SVProgressHUD.showError(withStatus: error as? String)
                            SVProgressHUD.dismiss(withDelay: 1.5)
                        }
                    }
                    SVProgressHUD.dismiss()
                    self.transToEmailVer()
                }
            
            }
                
        }
    }
    
    @objc func back(sender: UIButton!){
        
        UIView.animate(withDuration: 0.4) {
            self.view.alpha = 0
        }
    }
    
    func transToEmailVer(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let emailVerVC = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.marketplaceViewController) as? MarketPlaceViewController
        
        view.window?.rootViewController = emailVerVC
        let options: UIView.AnimationOptions = .transitionFlipFromRight

        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.7
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in
            
        }
        view.window?.makeKeyAndVisible()
    }
    
    func setupView(){
        var parent = self.view!
        
        // Welcome text label
        welcome_lbl.frame = CGRect(x: 0, y: 0, width: 143, height: 58)
        //welcome_lbl.backgroundColor = .white
        welcome_lbl.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        welcome_lbl.font = UIFont(name: "Gotham-Book", size: 24)
        welcome_lbl.numberOfLines = 0
        welcome_lbl.lineBreakMode = .byWordWrapping
        welcome_lbl.text = "Welcome to Kindling"
        parent.addSubview(welcome_lbl)
 
        
        // login button config
        sign_up.frame = CGRect(x: 0, y: 0, width: 132, height: 40)
        sign_up.backgroundColor = .white
        sign_up.layer.backgroundColor = UIColor(red: 0.369, green: 0.4, blue: 0.502, alpha: 1).cgColor
        sign_up.layer.cornerRadius = 5
        sign_up.setTitle("Sign Up", for: .normal)
        sign_up.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        parent.addSubview(sign_up)

        
        // back button config
        back_btn.frame = CGRect(x: 0, y: 0, width: 32, height: 40)
        back_btn.backgroundColor = .clear
        back_btn.layer.cornerRadius = 5
        back_btn.layer.borderWidth = 1
        back_btn.layer.borderColor = UIColor(red: 0.929, green: 0.294, blue: 0.282, alpha: 1).cgColor
        back_btn.setImage(UIImage(named:"back_arrow"), for: .normal)
        back_btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        parent.addSubview(back_btn)

        
        // email text field
        email_txtfld.backgroundColor = UIColor(red: 0.18, green: 0.17, blue: 0.24, alpha: 1.00)
        email_txtfld.attributedPlaceholder = NSAttributedString(string: "email",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.392, green: 0.431, blue: 0.537, alpha: 1), NSAttributedString.Key.font : UIFont(name: "Gotham", size:16)!])
        email_txtfld.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        parent.addSubview(email_txtfld)
     
        
        // adding line under email text field
        stroke_email.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_email.center = view.center
        view.addSubview(stroke_email)
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_email.layer.borderWidth = 2
        stroke_email.layer.borderColor = UIColor(red: 0.392, green: 0.431, blue: 0.537, alpha: 1).cgColor
        parent.addSubview(stroke_email)

        
        // password text field
        password_txtfld.backgroundColor =  UIColor(red: 0.18, green: 0.17, blue: 0.24, alpha: 1.00)
        password_txtfld.attributedPlaceholder = NSAttributedString(string: "password",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.392, green: 0.431, blue: 0.537, alpha: 1), NSAttributedString.Key.font : UIFont(name: "Gotham", size:16)!])
        password_txtfld.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        password_txtfld.isSecureTextEntry = true
        parent.addSubview(password_txtfld)

        
        // adding line under email text field
        stroke_password.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_password.center = view.center
        view.addSubview(stroke_password)
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_password.layer.borderWidth = 2
        stroke_password.layer.borderColor = UIColor(red: 0.392, green: 0.431, blue: 0.537, alpha: 1).cgColor
        parent.addSubview(stroke_password)

        
        // confirm password text field
        confirmPass_txtfld.backgroundColor =  UIColor(red: 0.18, green: 0.17, blue: 0.24, alpha: 1.00)
        confirmPass_txtfld.attributedPlaceholder = NSAttributedString(string: "re-enter password",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.392, green: 0.431, blue: 0.537, alpha: 1), NSAttributedString.Key.font : UIFont(name: "Gotham", size:16)!])
        confirmPass_txtfld.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        confirmPass_txtfld.isSecureTextEntry = true
        parent.addSubview(confirmPass_txtfld)

        
        // adding line under email text field
        stroke_confirmPass.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_confirmPass.center = view.center
        view.addSubview(stroke_confirmPass)
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_confirmPass.layer.borderWidth = 2
        stroke_confirmPass.layer.borderColor = UIColor(red: 0.392, green: 0.431, blue: 0.537, alpha: 1).cgColor
        parent.addSubview(stroke_confirmPass)
        
        self.view.backgroundColor = UIColor(red: 0.18, green: 0.17, blue: 0.24, alpha: 1.00)
        self.view.layer.cornerRadius = 10
    }
    
    
}


