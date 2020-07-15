//
//  EmailVerificationViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/30/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmailVerificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
//            if error != nil{
//                ProgressHUD.showError("Something went wrong...", interaction: false)
//            }
//        })
        // Do any additional setup after loading the view.
    }

    @IBAction func verifiedPressed(_ sender: Any) {
//        Auth.auth().currentUser?.reload(completion: { (error) in
//            if error != nil{
//                ProgressHUD.dismiss()
//                ProgressHUD.showError("Something went wrong...", interaction: false)
//            }
//            else{
//                if Auth.auth().currentUser?.isEmailVerified == true{
//                    ProgressHUD.dismiss()
//                    self.transToProf()
//                }
//                else{
//                    ProgressHUD.dismiss()
//                    ProgressHUD.showError("Please verify your email!", interaction: false)
//                }
//            }
//        })
        self.transToProf()
    }


    
    func transToProf(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: Constants.StoryBoard.marketplaceNavigationController)
        
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
