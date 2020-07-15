//
//  ProfileViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/2/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var profileImageBut: UIButton!
    var profileImgSet: UIImage?
    let defaults = UserDefaults.standard
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let default_bool = defaults.bool(forKey: "Default Profile Image")
        print(default_bool)
        profileImageBut.imageView?.layer.cornerRadius = profileImageBut.imageView!.bounds.width/2
        if (default_bool != true){
            ProgressHUD.show("Waiting...", interaction: false)
            let db = Firestore.firestore()
            db.collection("Users").document(Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
                if let error = error{
                    ProgressHUD.showError(error as! String)
                }
                if let data = snapshot!.data(){
                    let profileImgURL = data["Profile Picture URL"] as! String
                    self.profileImageBut!.sd_setImage(with: URL(string: profileImgURL), for: .normal) { (downloadedImg, error, cacheType, downloadURL) in
                    if(error != nil){
                        ProgressHUD.showError(error as! String)
                    }
                        ProgressHUD.dismiss()
                }
            }

        }
    }
    }
    
    @IBAction func changeProfImg(_ sender: Any) {
        let imagePickController = UIImagePickerController()
        imagePickController.delegate = self
        present(imagePickController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signOutAction(_ sender: Any) {
            do{
                try Auth.auth().signOut()
                transToLogIn()
            }
            catch let error{
                print(error as! String)
            }
        }
    
        func transToLogIn(){
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
    
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let logInVC = storyboard.instantiateViewController(identifier: Constants.StoryBoard.logInViewController) as? ViewController
    
            view.window?.rootViewController = logInVC
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.7
            UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in
    
            }

    }
}

        

