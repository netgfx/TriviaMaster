//
//  UserProfile.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 23/12/20.
//

import Foundation
import SwiftUI
import NavigationStack

struct UserProfile:View {
    
    @Binding var activeView:PushedItem?
    
    @ObservedObject private var userprogress:User = User.shared
    init(activeView:Binding<PushedItem?>) {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.init(red: 133/255, green: 87/255, blue: 160/255, alpha: 0)
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor.init(red: 133/255, green: 87/255, blue: 160/255, alpha: 0)
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().selectedImageTintColor = UIColor(cgColor: yellowColor.cgColor!)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "KGBlankSpaceSolid", size: 15)! ], for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        self._activeView = activeView
    }
    
    
    var body: some View {
            
            ZStack{
                SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
                VStack {
                    BackArrowWithoutTimer()
                    //ScrollView(.vertical){
                    VStack(spacing: 20){
                        VStack {
                            PushView(destination: ProfileEditor(activeView: $activeView)) {
                                Image("user").resizable()
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .frame(width: 96, height: 96, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            }
                            
                            Text(User.shared.getName()).font(.custom("KGBlankSpaceSolid", size: 18)).foregroundColor(.white)
                        }
                        
                        // CATEGORIES //
                        VStack(spacing:20){
                            HStack(spacing:20){
                                CategoryBox(category: "general", categoryName: "General", colorIndex: 0)
                                CategoryBox(category: "film", categoryName: "Film", colorIndex: 1)
                                CategoryBox(category: "tv", categoryName: "TV", colorIndex: 2)
                            }
                            HStack(spacing:20){
                                CategoryBox(category: "science", categoryName: "Science", colorIndex: 3)
                                CategoryBox(category: "geography", categoryName: "Geography", colorIndex: 4)
                                CategoryBox(category: "history", categoryName: "History", colorIndex: 5)
                            }
                            HStack(spacing:20){
                                CategoryBox(category: "sports", categoryName: "Sports", colorIndex: 6)
                                CategoryBox(category: "celebrity", categoryName: "Celebrity", colorIndex: 7)
                                CategoryBox(category: "computer", categoryName: "Computer", colorIndex: 8)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
}
