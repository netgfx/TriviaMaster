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
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack {
                BackArrowWithoutTimer()
                
                ScrollView{
                    VStack(spacing: 0){
                        ForEach(0..<8, id: \.self) { index in
                            HStack(spacing:0){
                                // layout the board 8x8
                                ForEach(0..<8, id: \.self) { innerIndex in
                                    if localMap[index][innerIndex]["type"] as! Int == 1 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(localMap[index][innerIndex]["color"] as! Color).frame(width: 42, height: 42, alignment: .center)
                                            Image(localMap[index][innerIndex]["category"] as! String).resizable().frame(width: 24, height: 24, alignment: .center)
                                        }
                                    }
                                    else if localMap[index][innerIndex]["type"] as! Int == 2 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(Color.white).frame(width: 42, height: 42, alignment: .center)
                                            Image("gem").resizable().frame(width: 24, height: 24, alignment: .center)
                                        }
                                    }
                                    else if localMap[index][innerIndex]["type"] as! Int == 5 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(localMap[index][innerIndex]["color"] as! Color).frame(width: 42, height: 42, alignment: .center)
                                            Image("gem").resizable().frame(width: 24, height: 24, alignment: .center)
                                        }
                                    }
                                    else if localMap[index][innerIndex]["type"] as! Int == 0 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0)).frame(width: 42, height: 42, alignment: .center)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: calculateMaze)
    }
}
