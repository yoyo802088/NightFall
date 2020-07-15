//
//  HomeViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/1/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var signOutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signOutAction(_ sender: Any) {
        try! Auth.auth().signOut()
        transToLogIn()
        
        
    }
    
    func transToLogIn(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let logInVC = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.logInViewController) as? ViewController
        
        view.window?.rootViewController = logInVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve

        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.7
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in
            
        }
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
