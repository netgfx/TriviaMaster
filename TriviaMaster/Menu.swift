//
//  Menu.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 30/12/20.
//

import Foundation
import SwiftUI
import NavigationStack

struct MenuView: View {
    @EnvironmentObject var layoutVars: LayoutVariables
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func fetchDataFor(category:String) {
        User.shared.resetCurrentChallengeProgress()
        if(category == "all"){
            API.shared.getAll()
        }
    }
    
    var body: some View {
        
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Select a Mode to Play").font(.custom("KGBlankSpaceSolid", size: 28)).foregroundColor(.white)
                
                VStack(spacing: 40){
                    Spacer()
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 50, content: {
                        VStack(spacing:10){
                            PushView(destination: Categories(activeView: $activeView)) {
                                Image("categories").resizable().frame(width: 64, height: 64, alignment: .center)
                            }
                            Text("Categories").font(.custom("KGBlankSpaceSolid", size: 24)).foregroundColor(.white)
                            
                        }
                        
                        VStack(alignment: .center){
                           PushView(destination: WheelMainView(activeView: $activeView)) {
                                Image("wheel").resizable().frame(width: 64, height: 64, alignment: .center)
                            }
                            Text("Challenge Wheel").font(.custom("KGBlankSpaceSolid", size: 24)).multilineTextAlignment(.center).foregroundColor(.white)
                        }
                    })
                    
                    HStack{
                        Spacer()
                        VStack(alignment: .center){
                           PushView(destination: GroupChallengeView(activeView: $activeView)) {
                                Image("group-challenge").resizable().frame(width: 64, height: 64, alignment: .center)
                            }
                            Text("Group Challenge").font(.custom("KGBlankSpaceSolid", size: 24)).multilineTextAlignment(.center).foregroundColor(.white)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                }
                Spacer()
                
            }.padding(.top, 44)
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true).navigationViewStyle(StackNavigationViewStyle()).onAppear(perform: {
            fetchDataFor(category: "all")
        })
    }
}
