//
//  GroupChallengeView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 5/1/21.
//

import Foundation
import SwiftUI
import Combine


struct GroupChallengeView:View {
    
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    @State var teamTurn:String = "white"
    @State var scaledTiles:Array<MazeLocation> = [MazeLocation(row: 0, col: 1), MazeLocation(row: 1, col: 0)]
    @State var whiteTeamKeys:Int = 0
    @State var blackTeamKeys:Int = 0
    var blocks = GroupChallenge()
    
    // pre-configure the board ;)
    var localMap:Array<Array<Dictionary<String, Any>>> = {
        var map:Array<Array<Dictionary<String, Any>>> = []
        var blocks = GroupChallenge()
        var counter = 0
        var items = blocks.getMap()
        for index in 0..<8 {
            var arr:Array<Dictionary<String, Any>> = []
            for innerIndex in 0..<8 {
                let category = blocks.getRandomType()
                print(items[counter])
                var innerItem:Dictionary<String, Any> = [
                    "type": items[counter],
                    "category": category,
                    "color": blocks.getColor(byCategory: category)
                ]
                
                arr.append(innerItem)
                counter += 1
            }
            map.append(arr)
            
        }
        
        return map
    }()
    
    func calculateMaze() {
        let start = MazeLocation(row: 0, col: 0)
        let maze = blocks.getMaze()
        let successors = successorsForMaze(maze)
        if let solution = dfs(initialState: start, goalTestFn: goalTest, successorFn: successors) {
            let path = nodeToPath(solution)
            print(path)
            //markMaze(&maze, path: path, start: start, goal: goal)
            printMaze(maze)
        }
        else {
            print("nothing")
        }
    }
    
    func printMaze(_ maze: Maze) {
        for i in 0..<maze.count {
            let val = maze[i].map{ $0.rawValue }
            print(String(val[0]))
        }
    }
    
    func onTileTapped(index:Int, innerIndex:Int) {
        print(index, innerIndex)
        self.removeMazeLocation(index: index, innerIndex: innerIndex)
    }
    
    func getTeamTurn() -> String {
        return self.teamTurn.uppercased()
    }
    
    func setScale(index:Int, innerIndex:Int) -> CGFloat {
        var result:CGFloat = 1.0
        
        // add logic to scale some tiles
        for item in self.scaledTiles {
            if item.row == index && item.col == innerIndex {
                result = 1.2
            }
        }
        
        return result
    }
    
    func setZIndex(index:Int, innerIndex:Int) -> Double {
        var result:Double = 1.0
        
        // add logic to scale some tiles
        for item in self.scaledTiles {
            if item.row == index && item.col == innerIndex {
                result = Double.random(in: 90..<99)
            }
        }
        
        return result
    }
    
    func setZRowIndex(index:Int) -> Double {
        var result:Double = 1.0
        
        // add logic to scale some tiles
        for item in self.scaledTiles {
            if item.row == index {
                result = Double.random(in: 90..<99)*Double(index)
            }
        }
        
        return result
    }
    
    func removeMazeLocation(index:Int, innerIndex: Int) {
        var counter:Int = 0
        for item in self.scaledTiles {
            if item.row == index {
                self.scaledTiles.remove(at: counter)
            }
            counter += 1
        }
    }
    
    func getTeamColor() -> Color {
        if self.teamTurn == "white" {
            return .white
        }
        else {
            return .black
        }
    }
    
    func getShadow(index:Int, innerIndex:Int) -> CGFloat {
        var result:CGFloat = 0.0
        
        // add logic to scale some tiles
        for item in self.scaledTiles {
            if item.row == index && item.col == innerIndex {
                result = 5.0
            }
        }
        
        return result
    }
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack {
                BackArrowWithoutTimer()
                
                ScrollView{
                    VStack(spacing: 0){
                        
                        HStack{
                            CustomText(text: self.getTeamTurn(), size: 20, color: self.getTeamColor())
                            CustomText(text: " Team Turn", size: 20, color: .white)
                        }.padding(.top, 20).padding(.bottom, 20)
                        
                        ForEach(0..<8, id: \.self) { index in
                            HStack(spacing:0){
                                // layout the board 8x8
                                ForEach(0..<8, id: \.self) { innerIndex in
                                    if localMap[index][innerIndex]["type"] as! Int == 1 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(localMap[index][innerIndex]["color"] as! Color).frame(width: 42, height: 42, alignment: .center)
                                            Image(localMap[index][innerIndex]["category"] as! String).resizable().frame(width: 24, height: 24, alignment: .center)
                                        }
                                        .zIndex(self.setZIndex(index:index, innerIndex:innerIndex))
                                        .scaleEffect(self.setScale(index: index, innerIndex: innerIndex), anchor: .center)
                                        .shadow(color: .black, radius: self.getShadow(index:index, innerIndex: innerIndex))
                                        .onTapGesture {
                                            self.onTileTapped(index: index, innerIndex: innerIndex)
                                        }
                                    }
                                    else if localMap[index][innerIndex]["type"] as! Int == 2 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(Color.white).frame(width: 42, height: 42, alignment: .center)
                                            Image("gem").resizable().frame(width: 24, height: 24, alignment: .center)
                                        }
                                        .zIndex(self.setZIndex(index:index, innerIndex:innerIndex))
                                        .scaleEffect(self.setScale(index: index, innerIndex: innerIndex), anchor: .center)
                                        .shadow(color: .black, radius: self.getShadow(index:index, innerIndex: innerIndex))
                                        .onTapGesture {
                                            self.onTileTapped(index: index, innerIndex: innerIndex)
                                        }
                                    }
                                    else if localMap[index][innerIndex]["type"] as! Int == 5 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(greyColor).frame(width: 42, height: 42, alignment: .center)
                                            Image("key").resizable().frame(width: 24, height: 24, alignment: .center)
                                        }
                                        .zIndex(self.setZIndex(index:index, innerIndex:innerIndex))
                                        .scaleEffect(self.setScale(index: index, innerIndex: innerIndex), anchor: .center)
                                        .shadow(color: .black, radius: self.getShadow(index:index, innerIndex: innerIndex))
                                        .onTapGesture {
                                            self.onTileTapped(index: index, innerIndex: innerIndex)
                                        }
                                    }
                                    else if localMap[index][innerIndex]["type"] as! Int == 0 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0)).frame(width: 42, height: 42, alignment: .center)
                                        }
                                    }
                                }
                            }.zIndex(setZRowIndex(index:index))
                        }
                    }.padding(10).edgesIgnoringSafeArea(.all)
                }.ignoresSafeArea().edgesIgnoringSafeArea(.all)
                
                // other controls //
                
                HStack {
                    Spacer()
                    HStack(spacing:10){
                        CustomText(text: "W", size: 51, color: .white)
                        CustomText(text: String(self.whiteTeamKeys)+"/3", size: 24, color:.white)
                    }
                    Spacer()
                    HStack(spacing:10){
                        CustomText(text: "B", size: 51, color: .black)
                        CustomText(text: String(self.blackTeamKeys)+"/3", size: 24, color:.black)
                    }
                    Spacer()
                }
                
                Spacer()
            }
        }.onAppear(perform: calculateMaze)
    }
}
