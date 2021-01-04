//
//  Categories.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 28/12/20.
//

import Foundation
import SwiftUI
import Combine
import NavigationStack

struct Categories: View {
    @EnvironmentObject var layoutVars: LayoutVariables
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    @State var isLoading:Bool = API.shared.isLoading
    @State var generalQuestions:[Question] = []
    @ObservedObject var apiHandler:API = API.shared
    
    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchDataFor(category:String) {
        User.shared.resetCurrentChallengeProgress()
        if(category == "all"){
            API.shared.getAll()
        }
    }
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            Router(activeView: $activeView)
            VStack {
                BackArrowWithoutTimer()
                
                VStack(spacing: 20){
                    
                    Text("Pick a Category to Play").font(.custom("KGBlankSpaceSolid", size: 24)).foregroundColor(.white)
                    if apiHandler.isLoading == true {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint:.white)).accentColor(.white).scaleEffect(CGSize(width: 1.5, height: 1.5))
                    }
                    else {
                   
                        VStack(spacing:20){
                            HStack(spacing:20){
                                PushView(destination: QuestionView(activeView: $activeView, category: "general", categoryName: "General", colorIndex: 0)){
                                    CategoryBox(showPercentage: false, category: "general", categoryName: "General", colorIndex: 0)
                                }
                                PushView(destination: QuestionView(activeView: $activeView, category: "film", categoryName: "Film", colorIndex: 1)){
                                    CategoryBox(showPercentage: false, category: "film", categoryName: "Film", colorIndex: 1)
                                }
                                PushView(destination: QuestionView(activeView: $activeView, category: "tv", categoryName: "TV", colorIndex: 2)){
                                    CategoryBox(showPercentage: false, category: "tv", categoryName: "TV", colorIndex: 2)
                                }
                            }
                            HStack(spacing:20){
                                PushView(destination: QuestionView(activeView: $activeView, category: "science", categoryName: "Science", colorIndex: 3)){
                                    CategoryBox(showPercentage: false, category: "science", categoryName: "Science", colorIndex: 3)
                                }
                                
                                PushView(destination: QuestionView(activeView: $activeView, category: "geography", categoryName: "Geography", colorIndex: 4)){
                                    CategoryBox(showPercentage: false, category: "geography", categoryName: "Geography", colorIndex: 4)
                                }
                                
                                PushView(destination: QuestionView(activeView: $activeView, category: "history", categoryName: "History", colorIndex: 5)){
                                    CategoryBox(showPercentage: false, category: "history", categoryName: "History", colorIndex: 5)
                                }
                            }
                            HStack(spacing:20){
                                PushView(destination: QuestionView(activeView: $activeView, category: "sports", categoryName: "Sports", colorIndex: 6)){
                                    CategoryBox(showPercentage: false, category: "sports", categoryName: "Sports", colorIndex: 6)
                                }
                                
                                PushView(destination: QuestionView(activeView: $activeView, category: "celebrity", categoryName: "Celebrity", colorIndex: 7)){
                                    CategoryBox(showPercentage: false, category: "celebrity", categoryName: "Celebrity", colorIndex: 7)
                                }
                                
                                PushView(destination: QuestionView(activeView: $activeView, category: "computer", categoryName: "Computer", colorIndex: 8)){
                                    CategoryBox(showPercentage: false, category: "computer", categoryName: "Computer", colorIndex: 8)
                                }
                            }
                        }.padding(.top, 50)
                    }
                }
                Spacer()
                if layoutVars.showTabBar == true {
                    BottomBar(activeView: $activeView)
                }
            }
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true).onAppear(perform: {
            fetchDataFor(category: "all")
        })
    }
}

// not used
struct WhiteShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color(red: 255/255, green: 255/255, blue: 255/255),
                    radius: 4.0, x: 1.0, y: 2.0)
    }
}
