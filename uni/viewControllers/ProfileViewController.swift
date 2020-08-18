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
import Lottie

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var ch2_talk: AnimationView!
    @IBOutlet weak var ch1_blink: AnimationView!
    
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
    
    }
    
    func startAnimation(){
        
        ch1_blink.contentMode = .scaleAspectFit
        ch1_blink.loopMode = .loop
        ch1_blink.play()
        
        ch2_talk.contentMode = .scaleAspectFit
        ch2_talk.loopMode = .loop
        ch2_talk.play()
    }
    
    @IBAction func change(_ sender: Any) {
      
        ch2_talk.animation = Animation.named("ch2_talk")
        ch2_talk.loopMode = .playOnce
        ch2_talk.play { (Success) in
            if Success{
                self.ch2_talk.animation = Animation.named("ch2_blink")
                self.ch2_talk.loopMode = .loop
                self.ch2_talk.play()
            }
        }
        
        
    }
    
}

        

