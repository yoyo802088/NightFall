//
//  LoadDemo_4.swift
//  Chat Animation
//
//  Created by LOGAN on 2020/7/1.
//  Copyright © 2020 LOGAN. All rights reserved.
//

import SwiftUI

struct LoadDemo_4: View {
    var body: some View {
        LottieView(filename: "DisableNodesTest")
        .position(x:80, y:50)
        .frame(width: 200, height: 200)
    }
}

struct LoadDemo_4_Previews: PreviewProvider {
    static var previews: some View {
        LoadDemo_4()
    }
}
