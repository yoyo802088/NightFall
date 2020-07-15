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

class SellPostViewController: UIViewController {
    
    
    
    @IBOutlet weak var sellPostBtnOne: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func sellAction(_ sender: Any) {
        ProgressHUD.show("Waiting...", interaction: false)
        let roomID = NSUUID().uuidString
        let currentDate = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: currentDate)
        let dataBaseRef = Firestore.firestore()
        let creatorID = Auth.auth().currentUser?.uid
        dataBaseRef.collection("Post Images").document(roomID as String).setData(["RoomID": roomID, "Title": self.titleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), "Category": self.categoryTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), "Date Posted": formattedDate, "Creator": creatorID!]) { (error) in
            if error != nil{
                ProgressHUD.showError(error as? String)
            }
            dataBaseRef.collection("Post Images").document(roomID as String).collection("Members").document(creatorID!).setData(["User ID": creatorID]){ (error) in
                if error != nil{
                    ProgressHUD.showError(error as? String)
                }
            }
            ProgressHUD.dismiss()
            self.navigationController!.popViewController(animated: true)
        }
    }
}

