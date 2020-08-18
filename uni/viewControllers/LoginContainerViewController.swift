//
//  LoginContainerViewController.swift
//  NightFall
//
//  Created by Yu-Shih Chen on 7/24/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SVProgressHUD


class LoginContainerViewController: UIViewController {
    var welcome_lbl = UILabel()
    var login_btn = UIButton()
    var back_btn = UIButton()
    var email_txtfld = UITextField()
    var password_txtfld = UITextField()
    var stroke_email = UIView()
    var stroke_password = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        // Do any additional setup after loading the view.
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
        
        back_btn.translatesAutoresizingMaskIntoConstraints = false
        back_btn.widthAnchor.constraint(equalToConstant: frame_width*(32/263)).isActive = true
        back_btn.heightAnchor.constraint(equalToConstant: frame_height*(40/348)).isActive = true
        back_btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(288/348)).isActive = true
        back_btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        
        login_btn.translatesAutoresizingMaskIntoConstraints = false
        login_btn.widthAnchor.constraint(equalToConstant: frame_width*(132/263)).isActive = true
        login_btn.heightAnchor.constraint(equalToConstant: frame_height*(40/348)).isActive = true
        login_btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(288/348)).isActive = true
        login_btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(87/263)).isActive = true
        
    }

    
    @objc func back(sender: UIButton!){
        
        UIView.animate(withDuration: 0.4) {
            self.view.alpha = 0
        }
    }

    
    @objc func logInAction(sender: UIButton!) {
      view.endEditing(true)
      SVProgressHUD.show(withStatus: "Waiting...")
      SVProgressHUD.setDefaultMaskType(.clear)
      let errorMessage = checkEmptyFields()
      if errorMessage != nil{
          SVProgressHUD.showError(withStatus: errorMessage!)
          SVProgressHUD.dismiss(withDelay: 1.5)
      }
      else{
          
          let processedSchoolEmail = email_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          let processedPassword = password_txtfld.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              Auth.auth().signIn(withEmail: processedSchoolEmail, password: processedPassword) { (result, error) in
                  
                  if error != nil{
                      SVProgressHUD.showError(withStatus: error!.localizedDescription)
                      SVProgressHUD.dismiss(withDelay: 1.5)
                  }
                  else{
                    SVProgressHUD.dismiss()
                    self.transToHome()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func checkEmptyFields() -> String? {
        
        //Check if fields are empty
        if email_txtfld.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password_txtfld.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please enter all fields!"
        }
        return nil
    }
    
    func transToHome(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: Constants.StoryBoard.marketplaceViewController)
        
        view.window?.rootViewController = homeVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.7
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in
            
        }

    }
    
    func setupView(){
        let parent = self.view!
        
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
        login_btn.frame = CGRect(x: 0, y: 0, width: 132, height: 40)
        login_btn.backgroundColor = .white
        login_btn.layer.backgroundColor = UIColor(red: 0.369, green: 0.4, blue: 0.502, alpha: 1).cgColor
        login_btn.layer.cornerRadius = 5
        login_btn.setTitle("login", for: .normal)
        login_btn.addTarget(self, action: #selector(logInAction), for: .touchUpInside)
        parent.addSubview(login_btn)

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
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.392, green: 0.431, blue: 0.537, alpha: 1)])
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
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.392, green: 0.431, blue: 0.537, alpha: 1)])
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
        
        self.view.backgroundColor = UIColor(red: 0.18, green: 0.17, blue: 0.24, alpha: 1.00)
        self.view.layer.cornerRadius = 10
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
