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
    var memberNum: Int?
    init(titleText: String, categoryText: String, roomIDText: String, memberNum: Int){
        self.title = titleText
        self.category = categoryText
        self.roomID = roomIDText
        self.memberNum = memberNum
    }
}
