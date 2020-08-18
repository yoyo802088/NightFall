//
//  EmailVerificationViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/30/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class EmailVerificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if error != nil{
                SVProgressHUD.showError(withStatus:"Something went wrong...")
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
            }
        })
        // Do any additional setup after loading the view.
    }

    @IBAction func verifiedPressed(_ sender: Any) {
        Auth.auth().currentUser?.reload(completion: { (error) in
            if error != nil{
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus:"Something went wrong...")
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
            }
            else{
                if Auth.auth().currentUser?.isEmailVerified == true{
                    SVProgressHUD.dismiss()
                    self.transToProf()
                }
                else{
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showError(withStatus:"Please verify your email!")
                    SVProgressHUD.setDefaultMaskType(.clear)
                    SVProgressHUD.dismiss(withDelay: 1.5)
                }
            }
        })
        //self.transToProf()
    }


    
    func transToProf(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: Constants.StoryBoard.marketplaceViewController) as! MarketPlaceViewController
        
        view.window?.rootViewController = homeVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.7
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in
            
        }
        view.window?.makeKeyAndVisible()
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
