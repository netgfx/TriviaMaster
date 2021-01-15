//
//  QuestionSheet.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 14/1/21.
//

import Foundation
import SwiftUI
import Combine
import Repeat

struct QuestionSheet:View {

    @Binding var questionPresented:Bool
    @Binding var isKey:Bool
    @Binding var keysForWhiteTeam:Int
    @Binding var keysForBlackTeam:Int
    @Binding var currentTeam:TeamTurn
    @State var currentQuestion = 1
    @State var victory:Bool = false
    @State var indexPressed:Int? = nil
    @ObservedObject var _Utils:Utils = Utils.shared
    @EnvironmentObject var layoutVars:LayoutVariables
    @State var completed = false
    @Binding var categoryName:String
    @Binding var categoryColor:Color
    
    var category:String = "general"
    var colors = [greenColor, pinkColor, purpleColor, goldColor, lightGreenColor, orangeColor, palePink, lightPurple, greenBlueColor]
    
    
    var totalQuestions = 10
    var timer:Repeater!
    var api:API = API.shared
    
    var elapsed = Utils.shared.$elapsedTime.sink(receiveCompletion: { print ($0) },
                                                 receiveValue: {
                                                    //print ($0)
                                                    if $0 == 0 {
                                                        print("show game over")
                                                    }
                                                 })
    
    func initTimer() {
        _Utils.setCurrentTime()
        _Utils.startTimer()
        // shuffle questions
        self.api.shuffleQuestions(forCategory: self.category)
    }
    
    func stopTimer() {
        _Utils.stopTimer()
    }
    
    func showCorrect() {
        print("showing correct but with red")
        completed = true
    }
    
    func checkAnswer(index:Int) {
        completed = true
        indexPressed = index
        stopTimer()
        
        let correct:Bool = checkCorrect(index: index)
        self.saveResult(isWin: correct)
    }
    
    func getCorrectAnswer() -> String {
        return String(api.categories[self.category]?[self.currentQuestion-1].correct_answer ?? "").htmlDecoded
    }
    
    func getQuestion(index:Int) -> String {
        return String(api.categories[self.category]?[self.currentQuestion-1].question ?? "").htmlDecoded
    }
    
    func getAnswer(index:Int) -> String {
        return String(api.categories[self.category]?[self.currentQuestion-1].incorrect_answers?[index] ?? "").htmlDecoded
    }
    
    func checkCorrect(index:Int) -> Bool {
        //indexPressed = index
        return getCorrectAnswer() == getAnswer(index: index)
    }
    
    
    func saveResult(isWin:Bool) {
        
        if isWin == true {
            if isKey == true {
                if self.currentTeam == .WHITE {
                    self.keysForWhiteTeam += 1
                }
                else {
                    self.keysForBlackTeam += 1
                }
            }
            MazeHelper.shared.setQuestion(success: true)
        }
        else {
            MazeHelper.shared.setQuestion(success: false)
        }
        
    }
    
    func getColor(index:Int) -> Color {
        
        if completed == true || _Utils.ended == true {
            
            let correct:Bool = checkCorrect(index: index)
            // correct and pressed
            if correct == true && indexPressed == index {
                // save result
                //self.saveResult(isWin:true)
                return correctGreen
            }
            // incorrect and pressed
            else if correct == false && indexPressed == index {
                //self.saveResult(isWin:false)
                return correctGreen
            }
            // correct and not pressed
            else if correct == true && indexPressed != index {
                //self.saveResult(isWin:false)
                return errorRed
            }
            // incorrect and not pressed
            else {
                //self.saveResult(isWin:false)
                return Color.init(red: 134/255, green: 86/255, blue: 179/255)
            }
        }
        else {
            return Color.init(red: 134/255, green: 86/255, blue: 179/255)
        }
    }
    
    func getVictory() -> Bool {
        return self.victory
    }
    func dismissView() {
        self.questionPresented.toggle()
    }
    
    var body: some View {
        
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Image("fail-particle").resizable().frame(width: 36, height: 36, alignment: .center).padding(.leading, 20).padding(.top, 15).onTapGesture(perform: self.dismissView)
                    Spacer()
                    if let _elapsedTime = _Utils.elapsedTime {
                        HStack(spacing:10) {
                            Image("timer").resizable().frame(width: 36, height: 36, alignment: .center)
                            Text(String(_elapsedTime)+"s").font(.custom("KGBlankSpaceSolid", size: 18)).foregroundColor(.white).padding(.trailing, 20)
                        }.padding(.top, 15).padding(.trailing, 10)
                    }
                }
                
                
                ZStack{
                    SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
                    ScrollView {
                        VStack(spacing: 20){
                            
                            HStack(spacing: 20){
                                Text("Question").font(.custom("KGBlankSpaceSolid", size: 34)).foregroundColor(.white)
                            }
                            Text(self.categoryName.capitalized).font(.custom("KGBlankSpaceSolid", size: 18)).foregroundColor(categoryColor).padding(.bottom, 10).padding(.leading, 10).padding(.trailing, 10)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white).frame(width: 345, height: 175, alignment: .center)
                                Text(getQuestion(index: 0)).font(.custom("KGBlankSpaceSolid", size: 16)).padding(.leading, 10).padding(.trailing, 10).foregroundColor(.black).fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 350, height: 175)
                                    .background(RoundedRectangle(cornerRadius: 15.0).stroke(categoryColor, lineWidth: 3).shadow(radius: 3))
                            }
                            
                            // Answers
                            VStack(spacing: 20){
                                if  _Utils.ended == true {
                                    //self.completed = true
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(getColor(index: 0)).frame(width: 345, height: 50, alignment: .center)
                                        Text(getAnswer(index: 0)).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: 345, height: 50)
                                            .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                                    }
                                }
                                else {
                                    // 1
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(getColor(index: 0)).frame(width: 345, height: 50, alignment: .center)
                                        Text(getAnswer(index: 0)).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: 345, height: 50)
                                            .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                                    }.onTapGesture(perform: {
                                        if indexPressed == nil {
                                            checkAnswer(index: 0)
                                        }
                                    })
                                }
                                
                                if   _Utils.ended == true {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(getColor(index: 1)).frame(width: 345, height: 50, alignment: .center)
                                        Text(getAnswer(index: 1)).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: 345, height: 50)
                                            .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                                    }
                                }
                                else {
                                    // 2
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(getColor(index: 1)).frame(width: 345, height: 50, alignment: .center)
                                        Text(getAnswer(index: 1)).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: 345, height: 50)
                                            .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                                    }.onTapGesture(perform: {
                                        if indexPressed == nil {
                                            checkAnswer(index: 1)
                                        }
                                    })
                                }
                                
                                if   _Utils.ended == true {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(getColor(index: 2)).frame(width: 345, height: 50, alignment: .center)
                                        Text(getAnswer(index: 2)).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: 345, height: 50)
                                            .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                                    }
                                }
                                else {
                                    // 3
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(getColor(index: 2)).frame(width: 345, height: 50, alignment: .center)
                                        Text(getAnswer(index: 2)).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: 345, height: 50)
                                            .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                                    }.onTapGesture(perform: {
                                        if indexPressed == nil {
                                            checkAnswer(index: 2)
                                        }
                                    })
                                }
                                
                                if   _Utils.ended == true {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(getColor(index: 3)).frame(width: 345, height: 50, alignment: .center)
                                        Text(getAnswer(index: 3)).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: 345, height: 50)
                                            .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                                    }
                                }
                                else {
                                    // 4
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(getColor(index: 3)).frame(width: 345, height: 50, alignment: .center)
                                        Text(getAnswer(index: 3)).font(.custom("KGBlankSpaceSolid", size: 16)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: 345, height: 50)
                                            .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                                    }.onTapGesture(perform: {
                                        if indexPressed == nil {
                                            checkAnswer(index: 3)
                                        }
                                    })
                                }
                            }.padding(.top, 10)
                            
                            if completed == true || _Utils.ended == true {
                                HStack(spacing:20){
                                    Text("Continue").font(.custom("KGBlankSpaceSolid", size: 24)).foregroundColor(.white)
                                    Image("next").resizable().frame(width: 32, height: 32, alignment: .center).padding(.top, 5)
                                }.padding(.top, 20).onTapGesture(perform: dismissView)
                            }
                            Spacer()
                        }
                        
                    }
                }
                
                
            }
            
        }.onAppear(perform: initTimer).onDisappear(perform: stopTimer)
    }
}
