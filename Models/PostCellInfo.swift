//
//  PostCellInfo.swift
//  uni
//
//  Created by Yu-Shih Chen on 1/4/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class PostCellInfo{
    var title: String?
    var category: String?
    var roomID: String?
    init(titleText: String, categoryText: String, roomIDText: String){
        title = titleText
        category = categoryText
        roomID = roomIDText
    }
}
