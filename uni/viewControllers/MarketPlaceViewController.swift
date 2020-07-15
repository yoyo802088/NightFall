//
//  MarketPlaceViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/2/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage
import SDWebImage
import FirebaseAuth

class MarketPlaceViewController: UIViewController {
    
    @IBOutlet weak var marketTableView: UITableView!
    var sellPosts = [PostCellInfo]()
    var refreshControl = UIRefreshControl()
    let defaults = UserDefaults.standard


    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let settings = FirestoreSettings()
//        settings.isPersistenceEnabled = false
//
//        // Any additional options
//        // ...
//
//        // Enable offline data persistence
//        let db = Firestore.firestore()
//        db.settings = settings
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        marketTableView.delegate = self
        marketTableView.dataSource = self
       
        loadPosts()
        
        
//        refreshControl.addTarget(self, action:  #selector(refresh), for: .valueChanged)
//        marketTableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsWhenVerticallyCompact = true //hidesBarsOnSwipe = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
//    @objc func refresh(sender:AnyObject) {
//       // Code to refresh table view
//        sellPosts = [PostCellInfo]()
//        loadPosts()
//        refreshControl.endRefreshing()
//    }
    
    func loadPosts(){
        let db = Firestore.firestore()
        db.collection("Post Images").order(by: "Date Posted", descending: true)
        db.collection("Post Images").addSnapshotListener { (QuerySnapshot, error) in
            if let query = QuerySnapshot{
                if query.documents.count == 0{
                    return
                }
                else{
                    query.documentChanges.forEach { (DocumentChange) in
                        if DocumentChange.type == .added {
                            let document = DocumentChange.document.data()
                            let titleText = document["Title"] as! String
                            let categoryText = document["Category"] as! String
                            let roomID = document["RoomID"] as! String
                            let post = PostCellInfo(titleText: titleText, categoryText: categoryText, roomIDText: roomID)
                            self.sellPosts.insert(post,at:0)  // appending not adjusting to current posts...
                            self.marketTableView.reloadData()

                            }
                        }
                    }
                }
            }
        }
    
    @IBAction func sellPostAction(_ sender: Any) {
        
        let currentUserID = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("Users").document(currentUserID).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let currentRoomID = dataDescription?["Current RoomID"] as! String
                if currentRoomID != "None"{
                    ProgressHUD.showError("Please quit the current room to create a new room!")
                }else{
                    let sellPostVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.sellPostViewController) as! SellPostViewController
                    self.navigationController!.pushViewController(sellPostVC, animated: true)
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}

extension MarketPlaceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Add animations here
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.7,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUserID = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        let currentRoomID = sellPosts[indexPath.row].roomID
        db.collection("Users").document(currentUserID).setData(["Current RoomID" : currentRoomID!], merge: true)
        db.collection("Post Images").document(currentRoomID! as String).collection("Members").document(currentUserID).setData(["User ID": currentUserID]){ (error) in
            if error != nil{
                ProgressHUD.showError(error as? String)
            }
        }
    
        let chatRoomVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.chatRoomViewController) as! chatRoomViewController
        self.navigationController!.setViewControllers([chatRoomVC], animated: true)
        //pushViewController(chatRoomVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sellPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marketTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.postTitleLbl.text = sellPosts[indexPath.row].title
        cell.categoryLbl.text = sellPosts[indexPath.row].category
        return cell
    }

}
