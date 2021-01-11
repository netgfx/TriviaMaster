//
//  DiceWheelMainView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 11/1/21.
//

import Foundation
import SwiftUI
import Combine

struct DiceWheelMainView:View {
    
    //@Binding var mazeHelper:MazeHelper
    
    var body: some View{
        VStack(alignment: .center){
            Image("down-arrow").resizable().frame(width: 42, height: 42, alignment: .center).padding(.top, 42)
            ZStack(alignment: .center){
                HStack{
                    Spacer()
                    DiceWheelView().frame(width: 110, height: 110, alignment: .center)
                    Spacer()
                }
            }
        }.padding(.top, -50)
    }
}
