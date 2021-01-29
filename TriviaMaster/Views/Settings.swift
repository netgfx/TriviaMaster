//
//  Settings.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 29/12/20.
//

import Foundation
import SwiftUI


struct Settings:View {
    @Binding var activeView:PushedItem?
    @State var diff:Double = User.shared.difficulty
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack {
                BackArrowWithoutTimer()
                
                VStack {
                    CustomText(text: "Settings", size: 24.0, color: .white).padding(.bottom, 20).padding(.bottom, 40)
                    HStack{
                        CustomText(text: "Difficulty:", size: 18, color: .white)
                        Spacer()
                    }.padding(.leading, 40)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15).fill(Color.white).frame(width: 345, height: 40, alignment: .center)
                        Slider(value: $diff, in: 0...2, step: 1,onEditingChanged: { editing in
                            print(editing, self.diff)
                            User.shared.setDifficulty(diff: self.diff)
                        }).padding(.leading, 40).padding(.trailing, 40).foregroundColor(.white).accentColor(yellowColor)
                    }
                    HStack{
                        CustomText(text: "Easy", size: 16, color: .white)
                        Spacer()
                        CustomText(text: "Medium", size: 16, color: .white)
                        Spacer()
                        CustomText(text: "Hard", size: 16, color: .white)
                    }.padding(.leading, 40).padding(.trailing, 40)
                }
                Spacer()
            }
        }
    }
}
