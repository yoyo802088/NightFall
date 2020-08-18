//
//  chatRoomViewController.swift
//  NightFall
//
//  Created by Yu-Shih Chen on 6/19/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import Lottie
import AVKit

class chatRoomViewController: UIViewController {
    
    @IBOutlet weak var top_containerView: UIView!
    @IBOutlet weak var chat_containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.076, green: 0.073, blue: 0.2, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        
       
        
        top_containerView.translatesAutoresizingMaskIntoConstraints = false
        top_containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        top_containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        top_containerView.widthAnchor.constraint(equalToConstant: frame_width).isActive = true
        top_containerView.widthAnchor.constraint(equalTo: top_containerView.heightAnchor, multiplier: 375/223.23).isActive = true
        
        chat_containerView.translatesAutoresizingMaskIntoConstraints = false
        
        chat_containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top_containerView.frame.height).isActive = true
        chat_containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        chat_containerView.widthAnchor.constraint(equalToConstant: frame_width).isActive = true
        chat_containerView.widthAnchor.constraint(equalTo: chat_containerView.heightAnchor, multiplier: 375/480).isActive = true


    }

    
    
}

