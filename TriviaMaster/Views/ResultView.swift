//
//  ResultView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 31/12/20.
//

import Foundation
import SwiftUI
import NavigationStack

struct ResultView:View {
    @EnvironmentObject var layoutVars: LayoutVariables
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    @Binding var victory:Bool
    var type:String
    
    func checkVictory() {
        print(self.victory)
    }
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if victory == true {
                    VStack(spacing: 20){
                        CustomText(text: "You won the \(self.type) Challenge", size: 24, color: .white).frame(width: 345, height: 175, alignment: .center).padding(.bottom, 40)
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
                }
                else {
                    VStack(spacing: 20){
                        CustomText(text: "The \(self.type) Challenge\nwas unsuccessful", size: 24, color: .white).frame(width: 345, height: 175, alignment: .center).padding(.bottom, 40)
                        ZStack{
                            VStack(spacing:50) {
                                HStack{
                                    Image("fail-particle").resizable().frame(width: 48, height: 48, alignment: .center)
                                    Spacer()
                                    Image("fail-particle").resizable().frame(width: 48, height: 48, alignment: .center)
                                }
                                HStack{
                                    Image("fail-particle").resizable().frame(width: 48, height: 48, alignment: .center)
                                    Spacer()
                                    Image("fail-particle").resizable().frame(width: 48, height: 48, alignment: .center)
                                }
                                HStack{
                                    Spacer()
                                    Image("fail-particle").resizable().frame(width: 48, height: 48, alignment: .center)
                                    Spacer()
                                }.padding(.top, 40)
                            }.padding(.leading, 40).padding(.trailing, 40)
                            
                            Image("fail").resizable().frame(width: 128, height: 128, alignment: .center).padding(.top, -40)
                        }
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
        }.onAppear(perform: checkVictory)
    }
}
