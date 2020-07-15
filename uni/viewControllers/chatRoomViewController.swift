//
//  chatRoomViewController.swift
//  NightFall
//
//  Created by Yu-Shih Chen on 6/19/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class chatRoomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        let currentUserID = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("Users").document(currentUserID).setData(["Current RoomID" : "None"], merge: true)
        
        let marketplaceVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.marketplaceViewController) as! MarketPlaceViewController
        self.navigationController!.setViewControllers([marketplaceVC], animated: true)
        
    }
    
}
