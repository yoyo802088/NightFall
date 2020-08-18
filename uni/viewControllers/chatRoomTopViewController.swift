//
//  chatRoomTopViewController.swift
//  NightFall
//
//  Created by Yu-Shih Chen on 8/13/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import Lottie
import AVKit
import FirebaseAuth
import FirebaseFirestore

class chatRoomTopViewController: UIViewController {

    @IBOutlet weak var quit_button: UIButton!
    @IBOutlet weak var quit_lbl: UILabel!
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var fire_animation: AnimationView!
    @IBOutlet weak var hill: UIImageView!
    @IBOutlet weak var hill_light: UIImageView!
    @IBOutlet weak var chat_bg: AnimationView!
    var avPlayer: AVPlayer!
    var avPlayerController = AVPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.076, green: 0.073, blue: 0.2, alpha: 1)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = quit_button.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.backgroundColor = UIColor(red: 0.076, green: 0.073, blue: 0.2, alpha: 1).cgColor
        blurEffectView.layer.opacity = 0.5
        //quit_button.insertSubview(blurEffectView, at: 0)
        quit_button.backgroundColor = .clear
        quit_button.layer.borderColor = UIColor(red: 0.929, green: 0.294, blue: 0.282, alpha: 0.7).cgColor
        quit_button.layer.borderWidth = 0.5
        quit_button.layer.cornerRadius = 3
        quit_lbl.textColor = .red
        quit_lbl.font = .boldSystemFont(ofSize: 16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        if fire_animation.isAnimationPlaying == false{
            fire_animation.play()
            chat_bg.play()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        
        chat_bg.translatesAutoresizingMaskIntoConstraints = false
        chat_bg.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        chat_bg.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        chat_bg.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        chat_bg.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        chat_bg.contentMode = .scaleAspectFill
        chat_bg.loopMode = .loop
        chat_bg.play()
        
        back_btn.translatesAutoresizingMaskIntoConstraints = false
        back_btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(32/223.23)).isActive = true
        back_btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: frame_width*(25/375)).isActive = true
        back_btn.widthAnchor.constraint(equalToConstant: frame_width*(36/375)).isActive = true
        back_btn.widthAnchor.constraint(equalTo: back_btn.heightAnchor, multiplier: 1).isActive = true
        
        quit_button.translatesAutoresizingMaskIntoConstraints = false
        quit_button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(-2/223.23)).isActive = true
        quit_button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: frame_width*(119/375)).isActive = true
        quit_button.widthAnchor.constraint(equalToConstant: frame_width*(140/375)).isActive = true
        quit_button.widthAnchor.constraint(equalTo: quit_button.heightAnchor, multiplier: 140/70).isActive = true
        
        quit_lbl.translatesAutoresizingMaskIntoConstraints = false
        quit_lbl.widthAnchor.constraint(equalToConstant: frame_width*(35/375)).isActive = true
        quit_lbl.heightAnchor.constraint(equalToConstant: frame_height*(20/223.23)).isActive = true
        quit_lbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(38/223.23)).isActive = true
        quit_lbl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(175/375)).isActive = true
        
        hill.translatesAutoresizingMaskIntoConstraints = false
        hill.widthAnchor.constraint(equalToConstant: frame_width*(450/375)).isActive = true
        hill.heightAnchor.constraint(equalToConstant: frame_height*(94.5/223.23)).isActive = true
        hill.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(138/223.23)).isActive = true
        hill.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(-38/375)).isActive = true

        
        hill_light.translatesAutoresizingMaskIntoConstraints = false
        hill_light.widthAnchor.constraint(equalToConstant: frame_width*(375/375)).isActive = true
        hill_light.heightAnchor.constraint(equalToConstant: frame_height*(95/223.23)).isActive = true
        hill_light.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(127/223.23)).isActive = true
        hill_light.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(0/375)).isActive = true
        
        fire_animation.translatesAutoresizingMaskIntoConstraints = false
        fire_animation.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(90/223.23)).isActive = true
        fire_animation.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fire_animation.widthAnchor.constraint(equalToConstant: frame_width*(150/375)).isActive = true
        fire_animation.widthAnchor.constraint(equalTo: fire_animation.heightAnchor, multiplier: 150/200.2).isActive = true
        fire_animation.backgroundColor = .clear
        
        start_animation()

    }
    
    @objc func didBecomeActive(){
        fire_animation.play()
        chat_bg.play()
    }
    
    func start_animation(){
        fire_animation.contentMode = .scaleAspectFill
        fire_animation.loopMode = .loop
        fire_animation.play()
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.StoryBoard.marketplaceViewController) as! MarketPlaceViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)

    }
    
    @IBAction func quit_btn(_ sender: Any) {
        print("pressed!")
        let defaults = UserDefaults.standard
        let currentUserID = Auth.auth().currentUser!.uid
        let currentAvatar = defaults.string(forKey: "Avatar")
        let currentRoomID = defaults.string(forKey: "currentRoomID")
        
        let db = Firestore.firestore()
        db.collection("Users").document(currentUserID).setData(["Current RoomID" : "None"], merge: true)
        db.collection("Post Images").document(currentRoomID!).getDocument { (document, error) in
            let data = document?.data()
            let currentNumber = data!["Number of Members"]

            if (currentNumber as! Int-1) == 0{
                db.collection("Post Images").document(currentRoomID!).setData(["Title" : ""])
            }else{
                db.collection("Post Images").document(currentRoomID!).setData([currentAvatar! : "", "Number of Members" : currentNumber as! Int-1], merge: true)
                db.collection("Post Images").document(currentRoomID!).collection("Members").document(currentUserID).delete()
            }
            self.transToHome()
        }
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
