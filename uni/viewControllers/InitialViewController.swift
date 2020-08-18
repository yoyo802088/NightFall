//
//  InitialViewController.swift
//  NightFall
//
//  Created by Yu-Shih Chen on 7/23/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import SVProgressHUD

class InitialViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var welcome_txt: UILabel!
    @IBOutlet weak var login_but: UIButton!
    @IBOutlet weak var signup_but: UIButton!
    @IBOutlet weak var guest_but: UIButton!

    @IBOutlet weak var terms_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupFields()
    }

    override func viewDidAppear(_ animated: Bool) {

        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        let attrs_normal = [
            NSAttributedString.Key.font : UIFont(name: "Gotham", size:16)!,
            NSAttributedString.Key.foregroundColor : UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)] as [NSAttributedString.Key : Any
        ]
        
        let attrs_terms = [
            NSAttributedString.Key.font : UIFont(name: "Gotham", size:14)!,
            NSAttributedString.Key.foregroundColor : UIColor(red: 0.555, green: 0.545, blue: 0.608, alpha: 1),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any
        ]
        
        welcome_txt.translatesAutoresizingMaskIntoConstraints = false
        welcome_txt.widthAnchor.constraint(equalToConstant: frame_width*(143/263)).isActive = true
        welcome_txt.heightAnchor.constraint(equalToConstant: frame_height*(58/348)).isActive = true
        welcome_txt.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                             constant: frame_width*(43/263)).isActive = true
        welcome_txt.topAnchor.constraint(equalTo: self.view.topAnchor,
                                         constant: frame_height*(23/348)).isActive = true
        
        
        let attributedString_login = NSMutableAttributedString(string:"")
        let loginTitleStr = NSMutableAttributedString(string:"login", attributes:attrs_normal)
        attributedString_login.append(loginTitleStr)
        login_but.translatesAutoresizingMaskIntoConstraints = false
        login_but.widthAnchor.constraint(equalToConstant: frame_width*(165/263)).isActive = true
        login_but.heightAnchor.constraint(equalToConstant: frame_height*(40/348)).isActive = true
        login_but.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(104/348)).isActive = true
        login_but.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        login_but.setAttributedTitle(attributedString_login, for: .normal)
        
        let attributedString_signUp = NSMutableAttributedString(string:"")
        let signupTitleStr = NSMutableAttributedString(string:"sign up", attributes:attrs_normal)
        attributedString_signUp.append(signupTitleStr)
        signup_but.translatesAutoresizingMaskIntoConstraints = false
        signup_but.widthAnchor.constraint(equalToConstant: frame_width*(165/263)).isActive = true
        signup_but.heightAnchor.constraint(equalToConstant: frame_height*(40/348)).isActive = true
        signup_but.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(159/348)).isActive = true
        signup_but.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        signup_but.setAttributedTitle(attributedString_signUp, for: .normal)
        
        
        let attributedString_guest = NSMutableAttributedString(string:"")
        let guestTitleStr = NSMutableAttributedString(string:"guest", attributes:attrs_normal)
        attributedString_guest.append(guestTitleStr)
        guest_but.translatesAutoresizingMaskIntoConstraints = false
        guest_but.widthAnchor.constraint(equalToConstant: frame_width*(165/263)).isActive = true
        guest_but.heightAnchor.constraint(equalToConstant: frame_height*(40/373)).isActive = true
        guest_but.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(214/348)).isActive = true
        guest_but.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(45/263)).isActive = true
        guest_but.setAttributedTitle(attributedString_guest, for: .normal)
        
        let attributedString_terms = NSMutableAttributedString(string:"")
        let termsTitleStr = NSMutableAttributedString(string:"terms & conditions", attributes:attrs_terms)
        attributedString_terms.append(termsTitleStr)
        terms_button.translatesAutoresizingMaskIntoConstraints = false
        terms_button.widthAnchor.constraint(equalToConstant: frame_width*(131/263)).isActive = true
        terms_button.heightAnchor.constraint(equalToConstant: frame_height*(16/348)).isActive = true
        terms_button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(312/348)).isActive = true
        terms_button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(69/263)).isActive = true
        terms_button.setAttributedTitle(attributedString_terms, for: .normal)
        
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor(red: 0.18, green: 0.17, blue: 0.24, alpha: 1.00)
        self.view.layer.cornerRadius = 10
        
    }
    
    func setupFields(){
        
        Utilities.styleTextField(welcome_txt)
        Utilities.styleFilledButton_1(login_but)
        Utilities.styleFilledButton_2(signup_but)
        Utilities.styleFilledButton_3(guest_but)
        terms_button.setTitleColor(UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1), for: .normal)
        welcome_txt.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        welcome_txt.font = UIFont(name: "Gotham-Book", size: 24)
        welcome_txt.numberOfLines = 0
        welcome_txt.lineBreakMode = .byWordWrapping
        welcome_txt.text = "Welcome to Kindling"
    }
    
    
    @IBAction func login_pressed(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: Constants.StoryBoard.loginContainerViewController)
                                            as? LoginContainerViewController {
            
            self.addChild(viewController)
            viewController.view.frame = self.view.frame
           // Add the view controller to the container.
            
            UIView.transition(with: self.view, duration: 0.40, options: [.transitionCrossDissolve], animations: {
                self.view.addSubview(viewController.view)
            }, completion: nil)
            
            viewController.didMove(toParent: self)
            
        }
        
    }
    @IBAction func signUp_pressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: Constants.StoryBoard.signUpViewController)
                                            as? SignUpViewController {
            
            self.addChild(viewController)
            viewController.view.frame = self.view.frame
           // Add the view controller to the container.
            
            UIView.transition(with: self.view, duration: 0.40, options: [.transitionCrossDissolve], animations: {
                self.view.addSubview(viewController.view)
            }, completion: nil)
            
            viewController.didMove(toParent: self)
            
        }
        
    }
    func transToProf(){
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
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func guest_pressed(_ sender: Any) {
        SVProgressHUD.showError(withStatus: "Guest feature not open. Please sign up!")
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.dismiss(withDelay: 1.5)

        //transToProf()
    }
    
    @IBAction func terms_pressed(_ sender: Any) {
        SVProgressHUD.showError(withStatus: "Nothing yet! :)")
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
}
