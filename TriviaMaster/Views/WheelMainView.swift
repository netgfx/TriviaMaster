//
//  WheelMainView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 28/12/20.
//

import Foundation
import SwiftUI
import Combine
import NavigationStack

struct WheelMainView: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    @State var isLoading:Bool = API.shared.isLoading
    @State var general:[Question] = API.shared.generalQuestions
    @ObservedObject var apiHandler:API = API.shared
    @State var slides = ["General", "Film", "TV", "Science", "Geography","History","Sports","Celebrity","Tech"]
    @State var slicePicked:Bool = false
    @State var sliceIndexPicked:Int = 0
    @State var size:CGSize = CGSize(width: 0.0, height: 0.0)
    var cancellables: Set<AnyCancellable> = []
    var colors = [greenColor, pinkColor, purpleColor, goldColor, lightGreenColor, orangeColor, palePink, lightPurple, greenBlueColor]
    
    func fetchDataFor(category:String) {
        User.shared.resetCurrentChallengeProgress()
        if(category == "general"){
            API.shared.getAll()
        }
    }
    
    func setSize(geometry:CGSize) -> Bool {
        DispatchQueue.main.async { self.size = geometry }
        
        return true
    }
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
           
            VStack {
                BackArrowWithoutTimer()
                
                ScrollView {
                VStack(alignment: .center, spacing: 10){
                   
                        Text("Tap the Wheel to Spin\nand play the picked Category Challenge").font(.custom("KGBlankSpaceSolid", size: 24)).foregroundColor(.white)
                        if apiHandler.isLoading == true {
                            Spacer()
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint:.white)).accentColor(.white).scaleEffect(CGSize(width: 1.5, height: 1.5))
                            Spacer()
                        }
                        else {
                            Image("down-arrow").resizable().frame(width: 48, height: 48, alignment: .center).padding(.top, 40)
                            
                            GeometryReader{ geometry in
                                if self.setSize(geometry: geometry.size){}
                            }
                                
                                ZStack{
                                    HStack(alignment: .center){
                                            Spacer()
                                            WheelUIView(slides: $slides, slicePicked: $slicePicked, sliceIndexPicked: $sliceIndexPicked)
                                            Spacer()
                                    }
                                }.frame(width: self.size.width, height: 300, alignment: .center)
                            
                           
                            
                        }
                    
                    if self.slicePicked == true {
                        PushView(destination: QuestionView(activeView: $activeView, category: slides[sliceIndexPicked].lowercased(), categoryName: slides[sliceIndexPicked], colorIndex: sliceIndexPicked)){
                            HStack{
                                CustomText(text: "Play!", size: 24, color: .white)
                                Image("next").resizable().frame(width: 32, height: 32, alignment: .center).padding(.top, 15)
                            }
                        }
                    }
                        
                    }
                }.ignoresSafeArea().edgesIgnoringSafeArea(.all)
            }
        }.onAppear(perform: {
            fetchDataFor(category: "general")
        })
    }
}
