//
//  BottomBar.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 29/12/20.
//

import Foundation
import SwiftUI

struct BottomBar:View {
    @Binding var activeView:PushedItem?
    @EnvironmentObject var navigationHelper: NavigationHelper
    var body: some View {
        
            HStack{
                VStack(spacing:20){
                        Image("usericon").resizable().frame(width: 38, height: 38, alignment: .center).onTapGesture(count: 1) {
                            
                            self.activeView = PushedItem.PROFILE
                            print("clicked ", self.activeView)
                        }
                    Text(User.shared.getName()).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white)
                }.padding(.leading, 40)
                Spacer()
                VStack(spacing:20){
                    
                        Image("barchart").resizable().frame(width: 38, height: 38, alignment: .center).onTapGesture(count: 1) {
                            print("clicked")
                            self.activeView = PushedItem.STATS
                        }
                   
                    Text("Stats").font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white)
                }
                Spacer()
                VStack(spacing:20){
                   
                        Image("help2").resizable().frame(width: 38, height: 38, alignment: .center).onTapGesture(count: 1) {
                            print("clicked")
                            self.activeView = PushedItem.HELP
                        }
                    
                    Text("Help").font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white)
                }
                Spacer()
                VStack(spacing:20){
                    
                        Image("settings").resizable().frame(width: 38, height: 38, alignment: .center).onTapGesture(count: 1) {
                            print("clicked")
                            self.activeView = PushedItem.SETTINGS
                        }
                    
                    Text("Settings").font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white)
                }.padding(.trailing, 40)
            }
        
    }
}
