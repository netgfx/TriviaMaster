//
//  Login.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 30/12/20.
//

import Foundation
import SwiftUI

struct LoginView: View{
    
    @State var username: String = ""
    @Binding var activeView: PushedItem?
    var body: some View {
        
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Welcome to\nTrivia Master").font(.custom("KGBlankSpaceSolid", size: 32)).foregroundColor(.white).multilineTextAlignment(.center)
                
                VStack{
                    Text("Enter a username").font(.custom("KGBlankSpaceSolid", size:18)).foregroundColor(.white).multilineTextAlignment(.leading).padding(.bottom, 20)
                    TextField("Username", text: $username).padding()
                        .background(SwiftUI.Color.white)
                        .cornerRadius(5.0)
                        .padding([.bottom, .leading, .trailing], 20)
                    RegisterButton(username: $username, activeView: $activeView)
                }.padding(.top, 100)
                Spacer()
            }.padding(.top, 100)
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct RegisterButton: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var username: String
    @Binding var activeView: PushedItem?
    var body: some View {
        VStack{
            
            Button(action: {
                print("Button tapped")
                if self.username != "" {
                    print("continue to menu")
                    // save it!
                    User.shared.setName(name: self.username)
                    activeView = .MENU
                    navigationHelper.selection = PushedItem.MENU.rawValue
                }
                else {
                    print("empty field")
                }
            }){
                Text("Register")
                    .font(.custom("KGBlankSpaceSolid", size: 28))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(greenColor)
                    .cornerRadius(15.0)
            }
        }
    }
}

