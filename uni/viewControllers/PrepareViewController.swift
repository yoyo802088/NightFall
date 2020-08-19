//
//  PrepareViewController.swift
//  NightFall
//
//  Created by Yu-Shih Chen on 8/16/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import Lottie
import FirebaseAuth
import AVKit
import SVProgressHUD

class PrepareViewController: UIViewController {

    @IBOutlet weak var fire_animation: AnimationView!
    @IBOutlet weak var planet: UIImageView!
    var avPlayer : AVPlayer!
    var avPlayerController = AVPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        

        SVProgressHUD.show(withStatus: "Loading...")
        let filepath: String? = Bundle.main.path(forResource: "bg for login", ofType: "mp4")
        let fileURL = URL.init(fileURLWithPath: filepath!)
        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        avPlayer = AVPlayer(url: fileURL)
        avPlayerController.player = avPlayer
        avPlayerController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        avPlayerController.showsPlaybackControls = false
        avPlayerController.videoGravity = .resizeAspectFill
        avPlayerController.player?.play()
        self.view.insertSubview(avPlayerController.view, at: 0)
        self.addChild(avPlayerController)

        avPlayerController.view.translatesAutoresizingMaskIntoConstraints = false
        avPlayerController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        avPlayerController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        avPlayerController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        avPlayerController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

        planet.translatesAutoresizingMaskIntoConstraints = false
        planet.widthAnchor.constraint(equalToConstant: frame_width*(420/375)).isActive = true
        planet.heightAnchor.constraint(equalToConstant: frame_height*(310/812)).isActive = true
        planet.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(600/812)).isActive = true
        planet.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(-15/375)).isActive = true

        fire_animation.backgroundColor = .clear
        fire_animation.translatesAutoresizingMaskIntoConstraints = false
        fire_animation.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(510/812)).isActive = true
        fire_animation.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fire_animation.widthAnchor.constraint(equalToConstant: frame_width*(250/375)).isActive = true
        fire_animation.widthAnchor.constraint(equalTo: fire_animation.heightAnchor, multiplier: 250/350).isActive = true


        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem, queue: .main) { [weak self] _ in
            self?.avPlayer?.seek(to: CMTime.zero)
            self?.avPlayer?.play()
            

        }
        start_animation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            
            if Auth.auth().currentUser != nil{
                SVProgressHUD.dismiss()
                SVProgressHUD.showSuccess(withStatus: "Already logged in!")
                SVProgressHUD.dismiss(withDelay: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.transToProf()
                }
            }else{
                SVProgressHUD.dismiss()
                SVProgressHUD.showSuccess(withStatus: "Please sign in!")
                SVProgressHUD.dismiss(withDelay: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.transToIntro()
                }
            }
        }
        //}
            
            
}
        
        

        
    func start_animation(){
        fire_animation.contentMode = .scaleAspectFill
        fire_animation.loopMode = .loop
        fire_animation.play()
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
    
    func transToIntro(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: Constants.StoryBoard.introMainViewController)
        
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


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


