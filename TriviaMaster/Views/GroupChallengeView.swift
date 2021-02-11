//
//  GroupChallengeView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 5/1/21.
//

import Foundation
import SwiftUI
import Combine
import NavigationStack

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
    @Published var whiteTeamKeys:Int = 0
    @Published var blackTeamKeys:Int = 0
    @Published var groupSession: GroupSession!
    
    var blocks = GroupChallenge()
    
    func loadStoredGame() {
        self.groupSession = User.shared.loadGroupSession()
        if self.groupSession == nil {
            print("no games are saved")
        }
    }
    
    func setTeamKeysFor(team:TeamTurn) {
        if team == .WHITE {
            whiteTeamKeys += 1
            if whiteTeamKeys > 3 {
                whiteTeamKeys = 3
            }
        }
        else {
            blackTeamKeys += 1
            if blackTeamKeys > 3 {
                blackTeamKeys = 3
            }
        }
    }
    
    func getKeysFor(team: TeamTurn) -> Int {
        if team == .WHITE {
            return whiteTeamKeys
        }
        else {
            return blackTeamKeys
        }
    }
    
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
        // useful for testing specific wheel results
        let _wheel = wheelResult
        // row based
        let teamCoords = self.teamTurn == .WHITE ? whiteTeamCurrentLocation : blackTeamCurrentLocation
        
        blocks.resetVisited()
        resetScaledTiles()
        let map = blocks.getMap2D()
        // we use flood fill algorithm to find all available points within a fixed range (wheel result) from the team coordinates
        for index in 0..<map.count {
            for innerIndex in 0..<map[index].count {
                blocks.floodFill(row: index, col: innerIndex, step: _wheel, teamPosition: teamCoords)
            }
        }
        print(blocks.getVisited())
        let visited = blocks.getVisited()
        
        self.scaledTiles.removeAll()
        for index in 0..<visited.count {
            for innerIndex in 0..<visited[index].count {
                if visited[index][innerIndex] == 2 {
                    // I initially tried DFS algorithm, but it is not smart enough to take shortest path depending where it starts from :(
                    // because of inate DFS shortcoming
                    // so we used BFS!
                    let path = BFS().findPath(start:MazeLocation(row: teamCoords.row,col:teamCoords.col), end:MazeLocation(row:index,col:innerIndex))
                    
                    if path.count-1 == _wheel {
                        self.scaledTiles.append(MazeLocation(row: index, col: innerIndex))
                    }
                }
            }
        }
        
        print(scaledTiles)
        
    }
    
    
    
    private init(){}
}

struct GroupChallengeView:View {
    
    @EnvironmentObject private var navigationStack: NavigationStack
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    @State var questionPresented:Bool = false
    @ObservedObject var mazeHelper:MazeHelper = MazeHelper.shared
    @State var scaledTiles:Array<MazeLocation> = MazeHelper.shared.scaledTiles
    @State var isKey:Bool = false
    @State var selectedCategory:String = "general"
    @State var selectedColor:Color = greenColor
    @State var locked:Bool = false
    @State var winningTeam:TeamTurn = .WHITE
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
    
    func onTileTapped(index:Int, innerIndex:Int) {
        print(index, innerIndex)
        
        // debug
//        if (index == 7 && innerIndex == 7) {
//            navigateToVictory()
//            return
//        }
        
        if self.mazeHelper.scaledTiles.contains(MazeLocation(row:index, col:innerIndex)) == true {
            self.selectedCategory = self.getCategoryFor(point: MazeLocation(row: index, col: innerIndex))
            self.selectedColor = self.getColorFor(point: MazeLocation(row: index, col: innerIndex))
            self.mazeHelper.pointSelectedLast = MazeLocation(row: index, col: innerIndex)
            // check if key
            self.isKey = self.blocks.getVectorTypeBy(point: MazeLocation(row: index, col: innerIndex)) == .Key
            // calculate type
            self.toggleQuestion()
        }
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
    
    func getArrowRowPositionFor(team:TeamTurn) -> Float {
        if team == .WHITE {
            let row = self.mazeHelper.whiteTeamCurrentLocation.row
            let steps = row * 42 // tile size
            return Float(steps) - (42*0.5)
        }
        else {
            let row = self.mazeHelper.blackTeamCurrentLocation.row
            let steps = row * 42 // tile size
            return Float(steps) - (42*0.5)
        }
    }
    
    func getArrowColumnPositionFor(team:TeamTurn) -> Float {
        if team == .WHITE {
            let col = self.mazeHelper.whiteTeamCurrentLocation.col
            let steps = col * 42 // tile size
            return Float(steps) - (42*0.5)
        }
        else {
            let col = self.mazeHelper.blackTeamCurrentLocation.col
            let steps = col * 42 // tile size
            return Float(steps) - (42*0.5)
        }
    }
    
    func getWhiteTeamPosition(row:Int, col: Int) -> some View {
        return Group{
            if self.mazeHelper.whiteTeamCurrentLocation.row == row && self.mazeHelper.whiteTeamCurrentLocation.col == col {
                
                AnimatedArrow(type: .WHITE)
            }
            else {
                Group{ EmptyView() }
            }
        }
    }
    
    func getBlackTeamPosition(row:Int, col: Int) -> some View {
        return Group{
            if self.mazeHelper.blackTeamCurrentLocation.row == row && self.mazeHelper.blackTeamCurrentLocation.col == col {
                AnimatedArrow(type: .BLACK)
            }
            else {
                EmptyView()
            }
        }
    }
    
    func onDismissQuestion() {
        if self.mazeHelper.questionSuccess == true {
            // check keys
            print("Keys are: ", self.mazeHelper.whiteTeamKeys, self.mazeHelper.blackTeamKeys)
            // team can re-roll
            locked = false
            // remove selected
            self.mazeHelper.resetScaledTiles()
            self.mazeHelper.setPosition(forTeam: self.getTeamTurnEnum(), position: self.mazeHelper.pointSelectedLast)
            //check for win
            if self.mazeHelper.isOnVictoryTile() == true {
                // show victory view
                if self.mazeHelper.getKeysFor(team: self.getTeamTurnEnum()) >= 3 {
                    print("victory")
                    self.winningTeam = self.getTeamTurnEnum()
                    self.locked = true
                }
                
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
    
    func navigateToVictory() {
        DispatchQueue.main.async {
            self.navigationStack.push(GroupResultView(activeView: $activeView, teamWon: self.$winningTeam))
        }
    }
    
    
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    BackArrowWithoutTimer()
                    Spacer()
                    Image("save").resizable().frame(width: 36, height: 36).onTapGesture {
                        User.shared.saveGroupSession(wTeamPos:self.mazeHelper.whiteTeamCurrentLocation, bTeamPos:self.mazeHelper.blackTeamCurrentLocation, currentTeamTurn:self.getTeamTurnEnum(), wTeamKeys:self.mazeHelper.whiteTeamKeys, bTeamKeys: self.mazeHelper.blackTeamKeys)
                    }
                }.padding(.trailing, 20)
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
                                            
                                            getWhiteTeamPosition(row:index, col: innerIndex)
                                            
                                            getBlackTeamPosition(row: index, col: innerIndex)
                                            
                                            
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
                                            
                                            getWhiteTeamPosition(row:index, col: innerIndex)
                                            
                                            getBlackTeamPosition(row: index, col: innerIndex)
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
                                            
                                            getWhiteTeamPosition(row:index, col: innerIndex)
                                            
                                            getBlackTeamPosition(row: index, col: innerIndex)
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
                        
                        VStack(spacing:5) {
                            HStack {
                                
                                HStack(spacing:10){
                                    Image("uikey").resizable().frame(width: 48, height: 48)
                                    //CustomText(text: "W", size: 51, color: .white)
                                    CustomText(text: String(self.mazeHelper.whiteTeamKeys)+"/3", size: 24, color:.white)
                                }.padding(.leading, 15)
                                Spacer()
                                HStack(spacing:10){
                                    Image("uikey").resizable().frame(width: 48, height: 48)
                                    //CustomText(text: "B", size: 51, color: .black)
                                    CustomText(text: String(self.mazeHelper.blackTeamKeys)+"/3", size: 24, color:.black)
                                }.padding(.trailing, 15)
                                
                            }
                            // other controls //
                            DiceWheelMainView(locked: $locked).disabled(locked)
                            
                            
                        }.padding(.top, 10).sheet(isPresented: $questionPresented, onDismiss: onDismissQuestion) {
                            
                            QuestionSheet(questionPresented: $questionPresented, isKey: $isKey, currentTeam: self.$mazeHelper.teamTurn, categoryName: $selectedCategory, categoryColor: $selectedColor)
                        }
                    }.padding(10).edgesIgnoringSafeArea(.all)
                    
                }.ignoresSafeArea().edgesIgnoringSafeArea(.all).onAppear(perform:{
                    self.mazeHelper.resetScaledTiles()
                    self.mazeHelper.loadStoredGame()
                    self.mazeHelper.setPosition(forTeam: .WHITE, position: MazeLocation(row:0, col:0))
                    self.mazeHelper.setPosition(forTeam: .BLACK, position: MazeLocation(row:0, col:0))
                })
            }
        }
    }
}
