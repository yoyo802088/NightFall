//
//  SellPostViewController.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/3/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase
import SVProgressHUD

class SellPostViewController: UIViewController {
    
    
    
    @IBOutlet weak var sellPostBtnOne: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var category_lbl: UILabel!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var back_btn: UIButton!
    var stroke_category = UIView()
    var stroke_title = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        setup_view()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        
        category_lbl.translatesAutoresizingMaskIntoConstraints = false
        category_lbl.widthAnchor.constraint(equalToConstant: frame_width*(78/375)).isActive = true
        category_lbl.heightAnchor.constraint(equalToConstant: frame_height*(20/812)).isActive = true
        category_lbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(85/812)).isActive = true
        category_lbl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(30/375)).isActive = true
        
        title_lbl.translatesAutoresizingMaskIntoConstraints = false
        title_lbl.widthAnchor.constraint(equalToConstant: frame_width*(38/375)).isActive = true
        title_lbl.heightAnchor.constraint(equalToConstant: frame_height*(20/812)).isActive = true
        title_lbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(263/812)).isActive = true
        title_lbl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(30/375)).isActive = true
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.widthAnchor.constraint(equalToConstant: frame_width*(234/375)).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: frame_height*(19.5/812)).isActive = true
        titleTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(301/812)).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(70/375)).isActive = true
        
        stroke_title.translatesAutoresizingMaskIntoConstraints = false
        stroke_title.widthAnchor.constraint(equalToConstant: frame_width*(234/375)).isActive = true
        stroke_title.heightAnchor.constraint(equalToConstant: frame_height*(1/812)).isActive = true
        stroke_title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(324/812)).isActive = true
        stroke_title.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(70/375)).isActive = true
        
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        categoryTextField.widthAnchor.constraint(equalToConstant: frame_width*(234/375)).isActive = true
        categoryTextField.heightAnchor.constraint(equalToConstant: frame_height*(19.5/812)).isActive = true
        categoryTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(140/812)).isActive = true
        categoryTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(70/375)).isActive = true
        
        stroke_category.translatesAutoresizingMaskIntoConstraints = false
        stroke_category.widthAnchor.constraint(equalToConstant: frame_width*(234/375)).isActive = true
        stroke_category.heightAnchor.constraint(equalToConstant: frame_height*(1/812)).isActive = true
        stroke_category.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(163/812)).isActive = true
        stroke_category.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(70/375)).isActive = true
        
        back_btn.translatesAutoresizingMaskIntoConstraints = false
        back_btn.widthAnchor.constraint(equalToConstant: frame_width*(32/375)).isActive = true
        back_btn.heightAnchor.constraint(equalToConstant: frame_height*(40/812)).isActive = true
        back_btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(547/812)).isActive = true
        back_btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(70/375)).isActive = true
        
        sellPostBtnOne.translatesAutoresizingMaskIntoConstraints = false
        sellPostBtnOne.widthAnchor.constraint(equalToConstant: frame_width*(193/375)).isActive = true
        sellPostBtnOne.heightAnchor.constraint(equalToConstant: frame_height*(40/812)).isActive = true
        sellPostBtnOne.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(547/812)).isActive = true
        sellPostBtnOne.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(111/375)).isActive = true
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func transToChat(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let chatRoomVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.chatRoomViewController) as! chatRoomViewController
        self.view.window?.rootViewController = chatRoomVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.4
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { (Bool) in

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
    
    func setup_view(){
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.076, green: 0.073, blue: 0.2, alpha: 1).cgColor,
          UIColor(red: 0.055, green: 0.046, blue: 0.108, alpha: 1).cgColor
        ]
        layer0.locations = [0.3, 0.9]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.insertSublayer(layer0, at: 0)
        
        var parent = self.view!

        // Welcome text label
        
        categoryTextField.backgroundColor = .clear
        categoryTextField.attributedPlaceholder = NSAttributedString(string: "Enter a category...",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1)])
        categoryTextField.textColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1)
        
        titleTextField.backgroundColor = .clear
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Express yourself...",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1)])
        titleTextField.textColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1)

        category_lbl.textColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1)
        category_lbl.font = UIFont(name: "Gotham-Book", size: 16)
        category_lbl.numberOfLines = 0
        category_lbl.lineBreakMode = .byWordWrapping
        category_lbl.text = "category:"
        
        
        title_lbl.textColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1)
        title_lbl.font = UIFont(name: "Gotham-Book", size: 16)
        title_lbl.numberOfLines = 0
        title_lbl.lineBreakMode = .byWordWrapping
        title_lbl.text = "title:"

        // back button config
        back_btn.backgroundColor = .clear
        back_btn.layer.cornerRadius = 5
        back_btn.layer.borderWidth = 1
        back_btn.layer.borderColor = UIColor(red: 0.929, green: 0.294, blue: 0.282, alpha: 1).cgColor
        
        sellPostBtnOne.backgroundColor = .clear
        sellPostBtnOne.layer.backgroundColor = UIColor(red: 0.929, green: 0.294, blue: 0.282, alpha: 1).cgColor
        sellPostBtnOne.layer.cornerRadius = 5


        // adding line under email text field
        stroke_category.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_category.center = view.center
        view.addSubview(stroke_category)
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_category.layer.borderWidth = 2
        stroke_category.layer.borderColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1).cgColor
        parent.addSubview(stroke_category)

        // adding line under email text field
        stroke_title.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_title.center = view.center
        view.addSubview(stroke_title)
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_title.layer.borderWidth = 2
        stroke_title.layer.borderColor = UIColor(red: 0.898, green: 0.855, blue: 0.604, alpha: 1).cgColor
        parent.addSubview(stroke_title)
        
        

        self.view.backgroundColor = UIColor(red: 0.18, green: 0.17, blue: 0.24, alpha: 1.00)
        self.view.layer.cornerRadius = 10
    }
    
    @IBAction func sellAction(_ sender: Any) {
//        SVProgressHUD.show(withStatus: "Waiting...")
//        SVProgressHUD.setDefaultMaskType(.clear)
        let defaults = UserDefaults.standard
        let roomID = NSUUID().uuidString
        let currentDate = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: currentDate)
        let dataBaseRef = Firestore.firestore()
        let creatorID = Auth.auth().currentUser?.uid
        dataBaseRef.collection("Post Images").document(roomID as String).setData(["RoomID": roomID, "Title": self.titleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), "Category": self.categoryTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), "Date Posted": formattedDate, "Creator": creatorID!, "Number of Members":1, "Avatar 1": creatorID!, "Avatar 2":"", "Avatar 3":"", "Avatar 4":""])
        dataBaseRef.collection("Post Images").document(roomID as String).collection("Members").document(creatorID!).setData(["avatar" : "Avatar 1"])
        dataBaseRef.collection("Users").document(creatorID! as String).setData(["Current RoomID" : roomID], merge: true)
        defaults.set(true, forKey: "Avatar 1")
        defaults.set(false, forKey: "Avatar 2")
        defaults.set(false, forKey: "Avatar 3")
        defaults.set(false, forKey: "Avatar 4")
        defaults.set("Avatar 1", forKey: "Avatar")
        defaults.set(roomID as String, forKey: "currentRoomID")
        defaults.set(1, forKey: "current_number")
        defaults.set(0, forKey: "join_count")
        SVProgressHUD.dismiss()
        self.transToChat()
                    
            
        }
    
    @IBAction func back_action(_ sender: Any) {
        
        transToHome()
    }
    
}

