//
//  GroupResultView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 26/1/21.
//

import Foundation
import SwiftUI
import NavigationStack

struct GroupResultView:View {
    @EnvironmentObject var layoutVars: LayoutVariables
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    @Binding var teamWon:TeamTurn
    
    func getTeamColor() -> Color {
        if self.teamWon == .WHITE {
            return Color.white
        }
        else {
            return Color.black
        }
    }
    
    func getTeamName() -> String {
        if self.teamWon == .WHITE {
            return "White"
        }
        else {
            return "Black"
        }
    }
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            ScrollView{
            VStack(spacing: 20) {
                    VStack(spacing: 20){
                        VStack(spacing: 10){
                            CustomText(text: "\(getTeamName()) Team", size: 24, color: getTeamColor())
                            CustomText(text: "won the challenge!", size: 24, color: .white).frame(width: 345, height: 45, alignment: .center).padding(.bottom, 40)
                        }
                        ZStack{
                            VStack(spacing:50) {
                                HStack{
                                    Image("won-particle").resizable().frame(width: 62, height: 62, alignment: .center)
                                    Spacer()
                                    Image("won-particle").resizable().frame(width: 62, height: 62, alignment: .center)
                                }
                                HStack{
                                    Image("won-particle").resizable().frame(width: 62, height: 62, alignment: .center)
                                    Spacer()
                                    Image("won-particle").resizable().frame(width: 62, height: 62, alignment: .center)
                                }
                                HStack{
                                    Spacer()
                                    Image("won-particle").resizable().frame(width: 62, height: 62, alignment: .center)
                                    Spacer()
                                }.padding(.top, 40)
                            }.padding(.leading, 40).padding(.trailing, 40)
                            
                            Image("prize").resizable().frame(width: 128, height: 128, alignment: .center).padding(.top, -40)
                        }
                    }
                
                VStack(spacing:10) {
                    Spacer()
                    PopView(destination: .root) {
                        VStack(spacing: 10){
                            Image("menuBack").resizable().frame(width: 48, height: 48, alignment: .center)
                            Text("Back to Menu").font(.custom("KGBlankSpaceSolid", size: 24)).foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
            }.padding(.top, 40)
            }
        }
    }
}
