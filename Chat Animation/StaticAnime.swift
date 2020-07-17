//
//  StaticAnime.swift
//  Chat Animation
//
//  Created by LOGAN on 2020/7/7.
//  Copyright © 2020 LOGAN. All rights reserved.
//

import SwiftUI
import Lottie

struct StaticAnime: UIViewRepresentable {
    typealias UIViewType = UIView
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<StaticAnime>) -> UIView{
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation  = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        animationView.play()
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([animationView.widthAnchor.constraint(equalTo:view.widthAnchor),
                                     animationView.heightAnchor.constraint(equalTo:view.heightAnchor)])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context:
        UIViewRepresentableContext<StaticAnime>){
    }
}

