//
//  Demo_1.swift
//  Chat Animation
//
//  Created by LOGAN on 2020/6/29.
//  Copyright © 2020 LOGAN. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView{
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation  = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([animationView.widthAnchor.constraint(equalTo:view.widthAnchor),
                                     animationView.heightAnchor.constraint(equalTo:view.heightAnchor)])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context:
        UIViewRepresentableContext<LottieView>){
    }
}
