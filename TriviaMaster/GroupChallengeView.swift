//
//  GroupChallengeView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 5/1/21.
//

import Foundation
import SwiftUI
import Combine

enum TeamTurn:String {
    case WHITE = "white"
    case BLACK = "black"
}

class MazeHelper: ObservableObject {
    static let shared = MazeHelper()
    @Published var scaledTiles: Array<MazeLocation> = []
    @Published var whiteTeamCurrentLocation:MazeLocation = MazeLocation(row: 0, col: 0)
    @Published var blackTeamCurrentLocation:MazeLocation = MazeLocation(row: 0, col: 0)
    @Published var teamTurn:TeamTurn = .WHITE
    @Published var pointSelectedLast:MazeLocation = MazeLocation(row: 0, col: 0)
    @Published var questionSuccess:Bool = false
    
    var blocks = GroupChallenge()
    
    
    func isOnVictoryTile() -> Bool {
        if blocks.getVectorTypeBy(point: self.pointSelectedLast) == .Goal {
            return true
        }
        else {
            return false
        }
    }
    
    func setQuestion(success:Bool) {
        print(success)
        self.questionSuccess = success
    }
    
    func resetScaledTiles() {
        self.scaledTiles.removeAll()
    }
    
    func setPosition(forTeam:TeamTurn, position:MazeLocation) {
        if forTeam == .WHITE {
            self.whiteTeamCurrentLocation = position
        }
        else {
            self.blackTeamCurrentLocation = position
        }
    }
    
    func calculateTiles(wheelResult:Int) {
        // calculate which tiles to scale based on current position and wheel result
        // TODO Add towards all routes
        print(wheelResult, whiteTeamCurrentLocation, blackTeamCurrentLocation)
        
        // row based
        let teamCoords = self.teamTurn == .WHITE ? whiteTeamCurrentLocation : blackTeamCurrentLocation
        
        let rowPoint = MazeLocation(row: teamCoords.row, col: teamCoords.col+wheelResult)
        let row:Cell = blocks.getVectorTypeBy(point: rowPoint)
        
        let colPoint = MazeLocation(row: teamCoords.row+wheelResult, col: teamCoords.col)
        let col:Cell = blocks.getVectorTypeBy(point: colPoint)
        
        let leftPoint:MazeLocation = MazeLocation(row: teamCoords.row-wheelResult, col: teamCoords.col)
        let left:Cell = blocks.getVectorTypeBy(point: leftPoint)
        
        let topPoint:MazeLocation = MazeLocation(row: teamCoords.row, col: teamCoords.col-wheelResult)
        let top:Cell = blocks.getVectorTypeBy(point: topPoint)
       
        
        self.scaledTiles.removeAll()
        
        print("Checking... \(row), \(col)", rowPoint, colPoint)
        if row != Cell.Blocked && row != Cell.NotFound{
            self.scaledTiles.append(rowPoint)
        }
        
        if col != Cell.Blocked && col != Cell.NotFound {
            self.scaledTiles.append(colPoint)
        }
        
        if left != Cell.Blocked && left != Cell.NotFound {
            self.scaledTiles.append(leftPoint)
        }
        
        if top != Cell.Blocked && top != Cell.NotFound {
            self.scaledTiles.append(topPoint)
        }
        
        print(scaledTiles)
        
    }
    
    private init(){}
}

struct GroupChallengeView:View {
    
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    @State var questionPresented:Bool = false
    @ObservedObject var mazeHelper:MazeHelper = MazeHelper.shared
    @State var scaledTiles:Array<MazeLocation> = MazeHelper.shared.scaledTiles
    @State var whiteTeamKeys:Int = 0
    @State var blackTeamKeys:Int = 0
    @State var isKey:Bool = false
    @State var selectedCategory:String = "general"
    @State var selectedColor:Color = greenColor
    @State var locked:Bool = false
    @State var questionSuccess:Bool = MazeHelper.shared.questionSuccess {
        willSet{
            print("willSet")
        }
        didSet{
            print("The question is: ", questionSuccess)
            if questionSuccess == true {
                // team can re-roll
                locked = false
            }
            else {
                self.goToNextTeam(index: self.mazeHelper.pointSelectedLast.row, innerIndex: self.mazeHelper.pointSelectedLast.col, movePos: false)
            }
        }
    }
    
    var colors = [greenColor, pinkColor, purpleColor, goldColor, lightGreenColor, orangeColor, palePink, lightPurple, greenBlueColor]
    //@State var whiteTeamCurrentPos:MazeLocation = MazeLocation(row: 0, col: 0)
    //@State var blackTeamCurrentPos:MazeLocation = MazeLocation(row: 0, col: 0)
    var blocks = GroupChallenge()
//    @State var slicePicked:Bool = false
//    @State var sliceIndexPicked:Int = 0
    
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
    
    func getCategoryFor(point:MazeLocation) -> String {
        let result = localMap[point.row][point.col]
        print(result)
        if let category = result["category"] as? String {
            return category
        }
        else {
            return "general"
        }
    }
    
    func getColorFor(point:MazeLocation) -> Color {
        if let color = localMap[point.row][point.col]["color"] as? Color {
            return color
        }
        else {
            return greenColor
        }
    }
    
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
        self.selectedCategory = self.getCategoryFor(point: MazeLocation(row: index, col: innerIndex))
        self.selectedColor = self.getColorFor(point: MazeLocation(row: index, col: innerIndex))
        self.mazeHelper.pointSelectedLast = MazeLocation(row: index, col: innerIndex)
        // calculate type
        self.toggleQuestion()
    }
    
    
    
    func goToNextTeam(index:Int, innerIndex: Int, movePos:Bool) {
        self.removeMazeLocation(index: index, innerIndex: innerIndex)
        // add persistence
        if self.mazeHelper.teamTurn == .WHITE {
            if movePos == true {
                self.mazeHelper.whiteTeamCurrentLocation = MazeLocation(row: index, col: innerIndex)
            }
            setTeamTurn(team: .BLACK)
        }
        else {
            if movePos == true {
                self.mazeHelper.blackTeamCurrentLocation = MazeLocation(row: index, col: innerIndex)
            }
            setTeamTurn(team: .WHITE)
        }
        
        self.locked = false
    }
    
    func setTeamTurn(team:TeamTurn) {
        self.mazeHelper.teamTurn = team
    }
    
    func getTeamTurn() -> String {
        return self.mazeHelper.teamTurn.rawValue.uppercased()
    }
    
    func getTeamTurnEnum() -> TeamTurn {
        return self.mazeHelper.teamTurn
    }
    
    func setScale(index:Int, innerIndex:Int) -> CGFloat {
        var result:CGFloat = 1.0
        
        // add logic to scale some tiles
        print(self.mazeHelper.scaledTiles)
        for item in self.mazeHelper.scaledTiles {
            if item.row == index && item.col == innerIndex {
                result = 1.2
            }
        }
        
        return result
    }
    
    func setZIndex(index:Int, innerIndex:Int) -> Double {
        var result:Double = 1.0
        
        // add logic to scale some tiles
        for item in self.mazeHelper.scaledTiles {
            if item.row == index && item.col == innerIndex {
                result = Double.random(in: 90..<99)
            }
        }
        
        return result
    }
    
    func setZRowIndex(index:Int) -> Double {
        var result:Double = 1.0
        
        // add logic to scale some tiles
        for item in self.mazeHelper.scaledTiles {
            if item.row == index {
                result = Double.random(in: 90..<99)*Double(index+1)
            }
        }
        
        return result
    }
    
    func removeMazeLocation(index:Int, innerIndex: Int) {
       
        // should probably remove them all
        self.mazeHelper.scaledTiles.removeAll()
//        for item in self.mazeHelper.scaledTiles {
//            if item.row == index {
//                self.mazeHelper.scaledTiles.remove(at: counter)
//            }
//            counter += 1
//        }
    }
    
    func getTeamColor() -> Color {
        if self.mazeHelper.teamTurn == .WHITE {
            return .white
        }
        else {
            return .black
        }
    }
    
    func getShadow(index:Int, innerIndex:Int, scaledTiles:Array<MazeLocation>) -> CGFloat {
        var result:CGFloat = 0.0
        
        // add logic to scale some tiles
        for item in scaledTiles {
            if item.row == index && item.col == innerIndex {
                result = 5.0
            }
        }
        
        return result
    }
    
    func onDismissQuestion() {
        if self.mazeHelper.questionSuccess == true {
            // team can re-roll
            locked = false
            // remove selected
            self.mazeHelper.resetScaledTiles()
            self.mazeHelper.setPosition(forTeam: self.getTeamTurnEnum(), position: self.mazeHelper.pointSelectedLast)
            //check for win
            if self.mazeHelper.isOnVictoryTile() == true {
                // show victory view
            }
            // continue as normal
        }
        else {
            self.goToNextTeam(index: self.mazeHelper.pointSelectedLast.row, innerIndex: self.mazeHelper.pointSelectedLast.col, movePos: false)
        }
    }
    
    func toggleQuestion() {
        self.questionPresented.toggle()
    }
    
    func getIndex(index:Int, innerIndex:Int) -> Bool {
        return (index == 0 && innerIndex == 0)
    }
    
    func getTileImage(index:Int, innerIndex:Int) -> some View {
        if getIndex(index:index, innerIndex: innerIndex) == true {
            return Image("start").resizable().frame(width: 32, height: 32, alignment: .center)
        }
        else {
            return Image(localMap[index][innerIndex]["category"] as! String).resizable().frame(width: 24, height: 24, alignment: .center)
        }
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
                                if  self.mazeHelper.scaledTiles.count > 0 {
                                    EmptyView()
                                }
                                // layout the board 8x8
                                ForEach(0..<8, id: \.self) { innerIndex in
                                    
                                    if localMap[index][innerIndex]["type"] as! Int == 1 {
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 10).fill(localMap[index][innerIndex]["color"] as! Color).frame(width: 42, height: 42, alignment: .center)
                                            // because it didn't work inline for...reasons...
                                            getTileImage(index:index, innerIndex: innerIndex)
                                        }
                                        .zIndex(self.setZIndex(index:index, innerIndex:innerIndex))
                                        .scaleEffect(self.setScale(index: index, innerIndex: innerIndex), anchor: .center)
                                        .shadow(color: .black, radius: self.getShadow(index:index, innerIndex: innerIndex, scaledTiles: self.mazeHelper.scaledTiles))
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
                                        .shadow(color: .black, radius: self.getShadow(index:index, innerIndex: innerIndex, scaledTiles: self.mazeHelper.scaledTiles))
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
                                        .shadow(color: .black, radius: self.getShadow(index:index, innerIndex: innerIndex, scaledTiles: self.mazeHelper.scaledTiles))
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
                        
                        VStack(spacing:20) {
                            // other controls //
                            DiceWheelMainView(locked: $locked).disabled(locked)
                            
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
                        }.padding(.top, 20).sheet(isPresented: $questionPresented, onDismiss: onDismissQuestion) {
                            
                            QuestionSheet(questionPresented: $questionPresented, isKey: $isKey, keysForWhiteTeam: $whiteTeamKeys, keysForBlackTeam: $blackTeamKeys, currentTeam: self.$mazeHelper.teamTurn, categoryName: $selectedCategory, categoryColor: $selectedColor)
                        }
                    }.padding(10).edgesIgnoringSafeArea(.all)
                    
                }.ignoresSafeArea().edgesIgnoringSafeArea(.all)
            }
        }.onAppear(perform: calculateMaze)
    }
}
