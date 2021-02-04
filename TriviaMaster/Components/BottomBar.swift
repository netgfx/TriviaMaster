//
//  BottomBar.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 29/12/20.
//

import Foundation
import SwiftUI
import NavigationStack

struct BottomBar:View {
    @Binding var activeView:PushedItem?
    @EnvironmentObject var navigationHelper: NavigationHelper
    @EnvironmentObject private var navigationStack: NavigationStack
    var body: some View {
        
            HStack{
                VStack(spacing:20){
                        Image("usericon").resizable().frame(width: 38, height: 38, alignment: .center).onTapGesture(count: 1) {
                            
                            //self.activeView = PushedItem.PROFILE
                            self.navigationStack.push(UserProfile(activeView: $activeView))
                            print("clicked ", self.activeView)
                        }
                    Text(User.shared.getName()).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white)
                }.padding(.leading, 40)
                Spacer()
                VStack(spacing:20){
                    
                        Image("barchart").resizable().frame(width: 38, height: 38, alignment: .center).onTapGesture(count: 1) {
                            print("clicked")
                            self.navigationStack.push(Stats(activeView: $activeView))
                        }
                   
                    Text("Stats").font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white)
                }
                Spacer()
                VStack(spacing:20){
                   
                        Image("help2").resizable().frame(width: 38, height: 38, alignment: .center).onTapGesture(count: 1) {
                            print("clicked")
                            //self.activeView = PushedItem.HELP
                            self.navigationStack.push(Help(activeView: $activeView))
                        }
                    
                    Text("Help").font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white)
                }
                Spacer()
                VStack(spacing:20){
                    
                        Image("settings").resizable().frame(width: 38, height: 38, alignment: .center).onTapGesture(count: 1) {
                            print("clicked")
                            //self.activeView = PushedItem.SETTINGS
                            self.navigationStack.push(Settings(activeView: $activeView))
                        }
                    
                    Text("Settings").font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white)
                }.padding(.trailing, 40)
            }
        
    }
}
