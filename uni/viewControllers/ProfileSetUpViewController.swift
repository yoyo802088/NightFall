//
//  ProfileSetUpViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/1/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class ProfileSetUpViewController: UIViewController {
    
    
    
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var profilePicBtn: UIButton!
    var profileImgSet: UIImage?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicBtn.imageView?.layer.cornerRadius = profilePicBtn.imageView!.bounds.width/2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setProfilePicAction(_ sender: Any) {
        
        let imagePickController = UIImagePickerController()
        imagePickController.delegate = self
        present(imagePickController, animated: true, completion: nil)
        
    }
    
    @IBAction func doneAction(_ sender: Any) {
        let currentUser = Auth.auth().currentUser
        let dataBaseRef = Firestore.firestore()

        if profilePicBtn.currentImage?.isEqual(UIImage(named: "cowpic")) != true{
            ProgressHUD.show("Waiting...", interaction: false)
            defaults.set(false, forKey: "Default Profile Image")
            let storageRef = Storage.storage().reference(forURL:"gs://unimarketplace-dd3f6.appspot.com").child("Profile Image").child(currentUser!.uid)
            if let profileImageSet = profileImgSet, let profileImageData = profileImageSet.jpegData(compressionQuality: 0.1){
                storageRef.putData(profileImageData, metadata: nil) { (metadata, error) in
                    if error != nil{
                        ProgressHUD.showError(error as? String)
                    }
                    storageRef.downloadURL { (URL, error) in
                        if error != nil{
                            ProgressHUD.showError(error as? String)
                        }
                        dataBaseRef.collection("Users").document(currentUser!.uid).setData(["Profile Picture URL": URL!.absoluteString], merge: true) { (error) in
                            if error != nil{
                                ProgressHUD.showError(error as? String)
                            }
                            ProgressHUD.dismiss()
                            self.transToHome()
                        }
                    }
                }
                
            }
        }
        else{
            ProgressHUD.showError("Please set a profile picture! Or press skip")
        }
}

    @IBAction func skipAction(_ sender: Any) {
        defaults.set(true, forKey: "Default Profile Image")
        transToHome()
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
extension ProfileSetUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            profileImgSet = image
            profilePicBtn.setImage(image, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}
