//
//  ContentView.swift
//  Chat Animation
//
//  Created by LOGAN on 2020/6/29.
//  Copyright © 2020 LOGAN. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var someNumber = ""
    @State var isPressedBut1 = false
    @State var isPressedBut2 = false
    @State var isPressedBut3 = false
    @State var isPressedBut4 = false
    @State var isDefault = true
    
    var body: some View {
        VStack {
            if isDefault {
                LoadStaticAnime()
            }
            
            Button(action: {
                self.isPressedBut1 = true
                self.isDefault = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isPressedBut1 = false
                    self.isDefault = true
                }
            }) {
                Text("Anime 1")
            }
            .position(x: 20, y: 50)
            .padding()
            
            Button(action: {
                self.isPressedBut2 = true
                self.isDefault = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isPressedBut2 = false
                    self.isDefault = true
                }
            }) {
                Text("Anime 2")
            }
            .position(x:20, y: 55)
            .padding()
            
            Button(action: {
                self.isPressedBut3 = true
                self.isDefault = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isPressedBut3 = false
                    self.isDefault = true
                }
            }) {
                Text("Anime 3")
            }
            .position(x:20, y: 60)
            .padding()
            
            Button(action: {
                self.isPressedBut4 = true
                self.isDefault = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isPressedBut4 = false
                    self.isDefault = true
                }
            }) {
                Text("Anime 4")
            }
            .position(x: 20, y: 65)
            .padding()
            
            if isPressedBut1 {
                LoadDemo_1()
            }
            
            if isPressedBut2 {
                LoadDemo_2()
            }
            
            if isPressedBut3 {
                LoadDemo_3()
            }
            
            if isPressedBut4 {
                LoadDemo_4()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
