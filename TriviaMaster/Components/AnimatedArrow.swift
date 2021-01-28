//
//  AnimatedArrow.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 27/1/21.
//

import Foundation
import SwiftUI
import Combine

struct AnimatedArrow:View {
    
    var type:TeamTurn
    @State var offset:CGFloat = -12.0
    private let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
    
    var body: some View{
        if type == .WHITE {
            Image("arrow-down-white").resizable().frame(width:20, height:20, alignment: .center).offset(y: self.offset).padding(.top, -12).onAppear {
                withAnimation(self.animation) {
                    self.offset = -22.0
                }
            }
        }
        else {
            Image("arrow-down-black").resizable().frame(width:20, height:20, alignment: .center).offset(y: self.offset).padding(.top, -12).rotationEffect(.degrees(-90)).onAppear {
                withAnimation(self.animation) {
                    self.offset = -22.0
                }
            }
        }
    }
}
