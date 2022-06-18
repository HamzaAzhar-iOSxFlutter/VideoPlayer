//
//  LoaderView.swift
//  VideoPlayer
//
//  Created by Hamza Azhar on 18/06/2022.
//

import SwiftUI

struct LoaderView: View {
    @State private var isAnimating = false
    var numberOfCircles = 5
    
    var body: some View {
        ZStack {
            ForEach(0..<self.numberOfCircles) { i in
                VStack {
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.blue.opacity(0.9))
                    Spacer()
                }.frame(width: 100, height: 100)
                    .opacity(1 - (Double(i) / Double(self.numberOfCircles)))
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
                    .animation(self.foreverAnimation(thisDelay: Double(i)))
                    .onAppear {
                        self.isAnimating = true
                }
            }
        }
    }
    
    func foreverAnimation(thisDelay: Double = 0) -> Animation {
        return Animation.easeInOut(duration: 1)
            .repeatForever(autoreverses: false)
            .delay(thisDelay/10)
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
