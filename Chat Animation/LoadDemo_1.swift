//
//  LoadDemo_1.swift
//  Chat Animation
//
//  Created by LOGAN on 2020/6/29.
//  Copyright © 2020 LOGAN. All rights reserved.
//

import SwiftUI

struct LoadDemo_1: View {
    var body: some View {
        LottieView(filename: "HamburgerArrow")
            .position(x:80, y:50)
            .frame(width: 200, height: 200)
            
    }
    
}

struct LoadDemo_1_Previews: PreviewProvider {
    static var previews: some View {
        LoadDemo_1()
    }
}
