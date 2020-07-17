//
//  LoadStaticAnime.swift
//  Chat Animation
//
//  Created by LOGAN on 2020/7/7.
//  Copyright © 2020 LOGAN. All rights reserved.
//

import SwiftUI

struct LoadStaticAnime: View {
    var body: some View {
        StaticAnime(filename: "PinJump")
        .frame(width: 200, height: 200)
        .offset(x:0, y:0)
    }
}

struct LoadStaticAnime_Previews: PreviewProvider {
    static var previews: some View {
        LoadStaticAnime()
    }
}
