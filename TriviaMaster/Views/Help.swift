//
//  Help.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 29/12/20.
//

import Foundation
import SwiftUI


struct Help:View {
    @Binding var activeView:PushedItem?
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack {
                BackArrowWithoutTimer()
                
                ScrollView{
                    VStack {
                        CustomText(text: "Help", size: 24.0, color: .white).padding(.bottom, 20)
                        
                        VStack(alignment: .leading, spacing: 20){
                            CustomText(text: "Modes:", size: 18, color: .white).padding(.leading, 40)
                            
                            CustomText(text: "There are two modes Category Challenge and Wheel Challenge, on the first the player needs to choose a category and answer a specific number of questions (depending on the difficulty setting) in order to win the challenge. \nFor the Wheel Challenge the user spins the wheel and the category challenge is picked randomly.", size: 16, color: .white).multilineTextAlignment(.leading).padding(.leading, 40).padding(.trailing, 20)
                        }.padding(.top, 40)
                    }
                }
                Spacer()
            
            }
        }
    }
}
