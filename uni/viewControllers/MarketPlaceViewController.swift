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
import SVProgressHUD

class TopPassThroughView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
    
class BotPassThroughView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}

class MarketPlaceViewController: UIViewController {
    
    @IBOutlet weak var marketTableView: UITableView!
    @IBOutlet weak var topPassThroughView: TopPassThroughView!
    @IBOutlet weak var botPassThroughView: BotPassThroughView!
    @IBOutlet weak var planet_pass: BotPassThroughView!
    @IBOutlet weak var shop_btn: UIButton!
    @IBOutlet weak var shop_lbl: UILabel!
    @IBOutlet weak var cat_btn: UIButton!
    @IBOutlet weak var cat_lbl: UILabel!
    @IBOutlet weak var profile_btn: UIButton!
    @IBOutlet weak var profile_lbl: UILabel!
    @IBOutlet weak var add_btn: UIButton!
    @IBOutlet weak var create_lbl: UILabel!
    @IBOutlet weak var planetView: UIImageView!
    @IBOutlet weak var back_btn: UIButton!
    
    var sellPosts = [PostCellInfo]()
    var refreshControl = UIRefreshControl()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        back_btn.isHidden = true
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.marketTableView.addSubview(refreshControl)
        
        self.view.backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.15 , alpha: 1.00)
        marketTableView.backgroundColor = .clear
        topPassThroughView.backgroundColor = .clear
        botPassThroughView.backgroundColor = .clear
        planet_pass.backgroundColor = .clear
        addTopFade()
        addBotFade()
        
        marketTableView.delegate = self
        marketTableView.dataSource = self
        
        setupFields()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadPosts()
    }
    

    override func viewDidLayoutSubviews() {
        let db = Firestore.firestore()
        let currentUserID = Auth.auth().currentUser!.uid
        db.collection("Users").document(currentUserID).getDocument { (document, error) in
        if let document = document, document.exists {
            let data = document.data()
            let currentRoomID = data!["Current RoomID"] as? String
            if currentRoomID != "None"{
                self.back_btn.isHidden = false
            }
            }
        }
        addPlanetFade()
        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        
        add_btn.translatesAutoresizingMaskIntoConstraints = false
        add_btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(695/812)).isActive = true
        add_btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        add_btn.widthAnchor.constraint(equalToConstant: frame_width*(53/375)).isActive = true
        add_btn.widthAnchor.constraint(equalTo: add_btn.heightAnchor, multiplier: 1).isActive = true
        
        back_btn.translatesAutoresizingMaskIntoConstraints = false
        back_btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(650/812)).isActive = true
        back_btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        back_btn.widthAnchor.constraint(equalToConstant: frame_width*(100/375)).isActive = true
        back_btn.widthAnchor.constraint(equalTo: add_btn.heightAnchor, multiplier: 100/50).isActive = true
        
        create_lbl.translatesAutoresizingMaskIntoConstraints = false
        create_lbl.widthAnchor.constraint(equalToConstant: frame_width*(85/375)).isActive = true
        create_lbl.heightAnchor.constraint(equalToConstant: frame_height*(11/812)).isActive = true
        create_lbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(755/812)).isActive = true
        create_lbl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(146/375)).isActive = true
        
        planetView.translatesAutoresizingMaskIntoConstraints = false
        planetView.widthAnchor.constraint(equalToConstant: frame_width*(507/375)).isActive = true
        planetView.heightAnchor.constraint(equalToConstant: frame_height*(271/812)).isActive = true
        planetView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(617/812)).isActive = true
        planetView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(-65/375)).isActive = true

        planet_pass.translatesAutoresizingMaskIntoConstraints = false
        planet_pass.widthAnchor.constraint(equalToConstant: frame_width*(375/375)).isActive = true
        planet_pass.heightAnchor.constraint(equalToConstant: frame_height*(100/812)).isActive = true
        planet_pass.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(720/812)).isActive = true
        planet_pass.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(0/375)).isActive = true
        
    }
    
    @objc func refresh() {
        sellPosts.removeAll()
        manuanLoad()
        refreshControl.endRefreshing()
    }
    
    @IBAction func back_func(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    func setupFields(){
        
        profile_lbl.textColor = UIColor(red: 0.351, green: 0.363, blue: 0.471, alpha: 1)
        shop_lbl.textColor = UIColor(red: 0.351, green: 0.363, blue: 0.471, alpha: 1)
        create_lbl.textColor = UIColor(red: 0.353, green: 0.365, blue: 0.471, alpha: 1)
        cat_btn.backgroundColor = .clear
        cat_btn.layer.cornerRadius = 3
        cat_btn.layer.borderWidth = 0.5
        cat_btn.layer.borderColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 0.7).cgColor
        cat_lbl.textColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1)
        
        back_btn.backgroundColor = .clear
        back_btn.layer.cornerRadius = 3
        back_btn.layer.borderWidth = 0.5
        back_btn.layer.borderColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 0.7).cgColor
        back_btn.setTitle("back to room", for: .normal)
        back_btn.setTitleColor(UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1), for: .normal)
        
    }
    
    func addTopFade() {
        let gradientLayer = CAGradientLayer()
        let backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.15 , alpha: 1.00)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 355, height: 70)
        gradientLayer.colors = [backgroundColor.withAlphaComponent(1).cgColor,backgroundColor.withAlphaComponent(1).cgColor, backgroundColor.withAlphaComponent(1).cgColor,backgroundColor.withAlphaComponent(0).cgColor,backgroundColor.withAlphaComponent(0).cgColor]
        topPassThroughView.layer.addSublayer(gradientLayer)
    }
    
    func addBotFade() {
        let gradientLayer = CAGradientLayer()
        let backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.15 , alpha: 1.00)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 355, height: 70)
        gradientLayer.colors = [backgroundColor.withAlphaComponent(0).cgColor, backgroundColor.withAlphaComponent(1).cgColor,backgroundColor.withAlphaComponent(1).cgColor]
        botPassThroughView.layer.addSublayer(gradientLayer)
        
    }
    
    func addPlanetFade(){
        let gradientLayer = CAGradientLayer()
        let backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.15 , alpha: 1.00)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:  self.view.frame.height*(100/812))
        gradientLayer.colors = [backgroundColor.withAlphaComponent(0).cgColor,backgroundColor.withAlphaComponent(0.8).cgColor, backgroundColor.withAlphaComponent(1).cgColor,backgroundColor.withAlphaComponent(1).cgColor]
        planet_pass.layer.addSublayer(gradientLayer)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsWhenVerticallyCompact = true //hidesBarsOnSwipe = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func manuanLoad(){
        let db = Firestore.firestore()
        db.collection("Post Images").order(by: "Date Posted", descending: false).getDocuments { (QuerySnapshot, Error) in
            if let query = QuerySnapshot{
                print("fetch")
                query.documentChanges.forEach { (DocumentChange) in
                    let document = DocumentChange.document.data()
                    print(document)
                    let titleText = document["Title"] as? String
                    let categoryText = document["Category"] as! String
                    let roomID = document["RoomID"] as! String
                    let currentMemberNum = document["Number of Members"] as! Int
                    let post = PostCellInfo(titleText: titleText!, categoryText: categoryText, roomIDText: roomID, memberNum: currentMemberNum)
                    self.sellPosts.insert(post,at:0)  // appending not adjusting to current posts...
                    
                }
                self.marketTableView.reloadData()
            }
        }
        
    }

    
    func loadPosts(){
        let db = Firestore.firestore()
        
        
        db.collection("Post Images").order(by: "Date Posted", descending: false).addSnapshotListener(includeMetadataChanges: false, listener: { (QuerySnapshot, error) in
            print(1)

            if let query = QuerySnapshot{
//                if query.documents.count == 0{
//                    print(0)
//                    return
//                }
//                else{
                    query.documentChanges.forEach { (DocumentChange) in
                        if DocumentChange.type == .added{
                            print(2)
                            let document = DocumentChange.document.data()
                            print(document)
                            let titleText = document["Title"] as? String
                            let categoryText = document["Category"] as! String
                            let roomID = document["RoomID"] as! String
                            let currentMemberNum = document["Number of Members"] as! Int
                            let post = PostCellInfo(titleText: titleText!, categoryText: categoryText, roomIDText: roomID, memberNum: currentMemberNum)
                            self.sellPosts.insert(post,at:0)  // appending not adjusting to current posts...
                            self.marketTableView.reloadData()
                        }
                         else if DocumentChange.type == .removed{
                            print("deleted!!")
                            self.marketTableView.reloadData()
                        }
                    }

//                }
            }

        })
        
    }
    
    func transToCreate(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: Constants.StoryBoard.sellPostViewController)
        
        view.window?.rootViewController = homeVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.7
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in
            
        }

    }
    
    
    
    @IBAction func create_room(_ sender: Any) {
        let currentUserID = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("Users").document(currentUserID).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let currentRoomID = dataDescription?["Current RoomID"] as! String
                if currentRoomID != "None"{
                    SVProgressHUD.showError(withStatus: "Please quit the current room to create a new room!")
                    SVProgressHUD.dismiss(withDelay: 1.5)
                }else{
                    self.transToCreate()
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}

extension MarketPlaceViewController: UITableViewDataSource, UITableViewDelegate{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sellPosts.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Add animations here
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.7,
            delay: 0.05 * Double(indexPath.section),
            animations: {
                cell.alpha = 1
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SVProgressHUD.show(withStatus: "Loading...")
        SVProgressHUD.setDefaultMaskType(.clear)
        let db = Firestore.firestore()
        let defaults = UserDefaults.standard
        let currentUserID = Auth.auth().currentUser!.uid
        let currentRoomID = sellPosts[indexPath.section].roomID
        db.collection("Users").document(currentUserID).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let userRoomID = dataDescription?["Current RoomID"] as! String
                print(userRoomID == currentRoomID! as String)
                if userRoomID != "None"{
                    if userRoomID == (currentRoomID! as String){
                        SVProgressHUD.showError(withStatus: "Please use the return button...:(")
                        SVProgressHUD.dismiss(withDelay: 1.5)
                    } else{
                        SVProgressHUD.showError(withStatus: "Please quit the current room to join a new room!")
                        SVProgressHUD.dismiss(withDelay: 1.5)
                    }
                    
                }else{
                    db.collection("Users").document(currentUserID).setData(["Current RoomID" : currentRoomID!], merge: true)
                    let post_images_col = db.collection("Post Images").document(currentRoomID! as String)
                    post_images_col.getDocument { (QuerySnapshot, Error) in
                        if Error != nil{
                            SVProgressHUD.showError(withStatus: Error as? String)
                            SVProgressHUD.dismiss(withDelay: 1.5)
                        } else{
                            let doc_data = QuerySnapshot?.data()
                            let current_number = doc_data?["Number of Members"] as? Int
                            if current_number == nil{
                                SVProgressHUD.showError(withStatus: "Room doesn't exist...please refresh the page")
                                SVProgressHUD.dismiss(withDelay: 1.5)
                            }
                            else{
                            if current_number! < 4{
                                defaults.set(false, forKey: "Avatar 1")
                                defaults.set(false, forKey: "Avatar 2")
                                defaults.set(false, forKey: "Avatar 3")
                                defaults.set(false, forKey: "Avatar 4")
                                defaults.set(currentRoomID! as String, forKey: "currentRoomID")
                                if((doc_data!["Avatar 1"] as? String) != ""){
                                    defaults.set(true, forKey: "Avatar 1")
                                }
                                if((doc_data!["Avatar 2"] as? String) != ""){
                                    defaults.set(true, forKey: "Avatar 2")
                                }
                                if((doc_data!["Avatar 3"] as? String) != ""){
                                    defaults.set(true, forKey: "Avatar 3")
                                }
                                if((doc_data!["Avatar 4"] as? String) != ""){
                                    defaults.set(true, forKey: "Avatar 4")
                                }
                                
                                if ((doc_data!["Avatar 1"] as? String) == ""){
                                    post_images_col.setData(["Avatar 1" : currentUserID], merge:true)
                                    post_images_col.collection("Members").document(currentUserID).setData(["avatar" : "Avatar 1"], merge:true)
                                    defaults.set("Avatar 1", forKey: "Avatar")
                                } else if ((doc_data!["Avatar 2"] as? String) == ""){
                                    post_images_col.setData(["Avatar 2" : currentUserID], merge:true)
                                    print("IM AVATAR 2")
                                    post_images_col.collection("Members").document(currentUserID).setData(["avatar" : "Avatar 2"], merge:true)
                                    defaults.set("Avatar 2", forKey: "Avatar")
                                } else if(( doc_data!["Avatar 3"] as? String) == ""){
                                    post_images_col.setData(["Avatar 3" : currentUserID], merge:true)
                                    post_images_col.collection("Members").document(currentUserID).setData(["avatar" : "Avatar 3"], merge:true)
                                    defaults.set("Avatar 3", forKey: "Avatar")
                                } else{
                                    post_images_col.setData(["Avatar 4" : currentUserID], merge:true)
                                    post_images_col.collection("Members").document(currentUserID).setData(["avatar" : "Avatar 4"], merge:true)
                                    defaults.set("Avatar 4", forKey: "Avatar")
                                }
                                post_images_col.setData(["Number of Members" : current_number!+1], merge:true)
                                defaults.set(current_number!+1, forKey: "current_number")
                                defaults.set(-1, forKey: "join_count")
                                
                                guard let window = UIApplication.shared.keyWindow else {
                                    return
                                }
                                
                                let chatRoomVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.chatRoomViewController) as! chatRoomViewController
                                self.view.window?.rootViewController = chatRoomVC
                                let options: UIView.AnimationOptions = .transitionCrossDissolve
                                let duration: TimeInterval = 0.4
                                UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in

                                }
                            } else{
                                SVProgressHUD.showError(withStatus: "Room is full :(")
                                SVProgressHUD.setDefaultMaskType(.clear)
                                SVProgressHUD.dismiss(withDelay: 1.5)
                            }
                            }
                            
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sellPosts.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marketTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.postTitleLbl.text = sellPosts[indexPath.section].title
        cell.postTitleLbl.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        cell.postTitleLbl.font = .boldSystemFont(ofSize: 16)
        cell.categoryLbl.text = sellPosts[indexPath.section].category
        cell.categoryLbl.textColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1)
        let current_memberNum = sellPosts[indexPath.section].memberNum
        if current_memberNum == 1{
            cell.memImg_1.image = UIImage(named: "filled_member")
        } else if current_memberNum == 2{
            cell.memImg_1.image = UIImage(named: "filled_member")
            cell.memImg_2.image = UIImage(named: "filled_member")
        } else if current_memberNum == 3{
            cell.memImg_1.image = UIImage(named: "filled_member")
            cell.memImg_2.image = UIImage(named: "filled_member")
            cell.memImg_3.image = UIImage(named: "filled_member")
        } else{
            cell.memImg_1.image = UIImage(named: "full_member")
            cell.memImg_2.image = UIImage(named: "full_member")
            cell.memImg_3.image = UIImage(named: "full_member")
            cell.memImg_4.image = UIImage(named: "full_member")
            cell.enter_img.image = UIImage(named: "full_enter")
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.10, green: 0.09, blue: 0.16, alpha: 1.00)
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius = 5
        cell.backgroundColor = .clear
        cell.backgroundColor = UIColor(red: 0.18, green: 0.17, blue: 0.24, alpha: 1.00)
        return cell
    }

}

