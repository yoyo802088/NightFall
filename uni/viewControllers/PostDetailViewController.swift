//
//  PostDetailViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 3/1/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage

class PostDetailViewController: UIViewController {
    
    
    @IBOutlet weak var post_title: UILabel!
    @IBOutlet weak var post_img: UIImageView!
    @IBOutlet weak var post_desc: UILabel!
    @IBOutlet weak var user_thumb: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.hidesBarsOnSwipe = false
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    
        

    }

}
