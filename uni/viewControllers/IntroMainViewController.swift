//
//  IntroMainViewController.swift
//  NightFall
//
//  Created by Yu-Shih Chen on 7/24/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import AVKit
import Lottie
import FirebaseAuth


class IntroMainViewController: UIViewController {

    
    //let backgroundImage = UIImage(named: "login_back")
    
    @IBOutlet weak var intro_collectionView: UIView!
    @IBOutlet weak var planet: UIImageView!
    @IBOutlet weak var fire_animation: AnimationView!
    var avPlayer : AVPlayer!
    var avPlayerController = AVPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.backgroundColor = UIColor(red: 0.076, green: 0.071, blue: 0.117, alpha: 0.76).cgColor
        blurEffectView.layer.opacity = 0.8
        self.view.insertSubview(blurEffectView, at: 2)
        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        intro_collectionView.translatesAutoresizingMaskIntoConstraints = false
        intro_collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(128/812)).isActive = true
        intro_collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        intro_collectionView.widthAnchor.constraint(equalToConstant: frame_width*(263/375)).isActive = true
        intro_collectionView.widthAnchor.constraint(equalTo: intro_collectionView.heightAnchor, multiplier: 263/348).isActive = true
        
        let filepath: String? = Bundle.main.path(forResource: "bg for login", ofType: "mp4")
        let fileURL = URL.init(fileURLWithPath: filepath!)

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
        fire_animation.widthAnchor.constraint(equalToConstant: frame_width*(300/375)).isActive = true
        fire_animation.widthAnchor.constraint(equalTo: fire_animation.heightAnchor, multiplier: 300/380).isActive = true
        
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem, queue: .main) { [weak self] _ in
            self?.avPlayer?.seek(to: CMTime.zero)
            self?.avPlayer?.play()
            
        
        }
        start_animation()
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
    func addBackground(imageName: String = "YOUR DEFAULT IMAGE NAME", contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)

        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
