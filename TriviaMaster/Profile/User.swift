//
//  User.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 21/12/20.
//

import Foundation
import Combine
import SwiftUI

class CategoryStats:NSObject, Decodable, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(type, forKey: "type")
        coder.encode(wins, forKey: "wins")
        coder.encode(total, forKey: "total")
        coder.encode(percentage, forKey: "percentage")
    }
    
    required convenience init?(coder: NSCoder) {
        guard let type = coder.decodeObject(forKey: "type") as? String,
                  let total = coder.decodeObject(forKey: "total") as? Int,
                  let wins = coder.decodeObject(forKey: "wins") as? Int,
                  let percentage = coder.decodeObject(forKey: "percentage") as? Int
            else { return nil }

            self.init(
                type: type,
                total: total,
                wins: wins,
                percentage: percentage
            )
    }
    
    func getData() -> Dictionary<String, Any> {
        return ["type": self.type, "wins": self.wins, "total": self.total, "percentage": self.percentage]
    }
    
    static func == (lhs: CategoryStats, rhs: CategoryStats) -> Bool {
        return lhs.type == rhs.type
    }
    
//    func hash(into hasher: inout Hasher) {
//            hasher.combine(type)
//            //hasher.combine(name) if userId was not unique, we could have added this
//    }
    
    var type:String
    var total:Int
    var wins:Int
    var percentage:Int
    
    init(type:String, total:Int, wins:Int, percentage:Int) {
        self.type = type
        self.total = total
        self.wins = wins
        self.percentage = percentage
    }
    
    func increaseWinValue() {
        self.wins += 1
        self.total += 1
    }
    
    func increaseTotalValue(){
        self.total += 1
    }
    
    func calcPercentageValue() {
        self.percentage = Int((Float(self.wins) / Float(self.total)) * 100)
    }
}

class User: ObservableObject {
    static let shared = User()
    
    @Published var profileImageURL:String = ""
    @Published var currentChallengeProgress:Int = 0
    @Published var difficulty:Double = 0
    @Published var categories:Dictionary<String,CategoryStats> = [
        "general": CategoryStats(type: "general", total: 0, wins: 0, percentage: 0),
        "film":CategoryStats(type: "film", total: 0, wins: 0, percentage: 0),
        "tv":CategoryStats(type: "tv", total: 0, wins: 0, percentage: 0),
        "science":CategoryStats(type: "science", total: 0, wins: 0, percentage: 0),
        "geography":CategoryStats(type: "geography", total: 0, wins: 0, percentage: 0),
        "history":CategoryStats(type: "history", total: 0, wins: 0, percentage: 0),
        "celebrity":CategoryStats(type: "celebrity", total: 0, wins: 0, percentage: 0),
        "sports":CategoryStats(type: "sports", total: 0, wins: 0, percentage: 0),
        "computer":CategoryStats(type: "computer", total: 0, wins: 0, percentage: 0),
    ]
    let defaults = UserDefaults.standard
    
    func getDifficulty() -> String {
        if self.difficulty == 0 {
            return "easy"
        }
        else if self.difficulty == 1 {
            return "medium"
        }
        else if self.difficulty == 2 {
            return "hard"
        }
        else {
            return "easy"
        }
    }
    
    func setDifficulty(diff:Double) {
        self.difficulty = diff
        self.storeDifficulty()
    }
    
    func storeDifficulty() {
        defaults.setValue(self.difficulty, forKey: "user_settings")
    }
    
    func loadSettings() {
        if let diff = defaults.value(forKey: "user_settings") as? Double {
            self.difficulty = diff
        }
    }
    
    func getCurrentChallengeProgress() -> Int {
        print("Returning: ", self.currentChallengeProgress, (self.currentChallengeProgress/10))
        let div = Float(self.currentChallengeProgress) / 10
        let perc = div * 100
        return Int(perc)
    }
    
    func setCurrentChallengeProgress(isWin:Bool) {
        if isWin == true {
            self.currentChallengeProgress += 1
        }
        else {
            // no increase
        }
    }
    
    func resetCurrentChallengeProgress() {
        self.currentChallengeProgress = 0
    }
    
    func setName(name:String) {
        defaults.setValue(name, forKey: "username")
    }
    
    func getName() -> String {
        return defaults.string(forKey: "username") ?? ""
    }
    
    func setProfileImgURL(imgURL: String)  {
        defaults.setValue(imgURL, forKey: "profileImgURL")
        self.profileImageURL = imgURL
    }
    
    func getProfileImgURL() -> String {
        self.profileImageURL = defaults.string(forKey: "profileImgURL") ?? ""
        return self.profileImageURL
    }
    
    func setResultFor(category:String, isWin:Bool){
        if isWin {
            categories[category]?.increaseWinValue()
            categories[category]?.calcPercentageValue()
        }
        else {
            categories[category]?.increaseTotalValue()
            categories[category]?.calcPercentageValue()
        }
        
        self.storeData()
    }
    
    func getPercentageFor(category:String) -> String? {
        if let cat = categories[category] {
            return String(cat.percentage)+"%"
        }
        
        return nil
    }
    
    func getWinPercentageByDifficulty() -> Int {
        if self.getDifficulty() == "easy" {
            return 50
        }
        else if self.getDifficulty() == "medium" {
            return 70
        }
        else if self.getDifficulty() == "hard" {
            return 90
        }
        else {
            return 50
        }
    }
    
    func storeData() {
        let encodedData = self.exportData()
        defaults.setValue(encodedData, forKey: "user_stats")
    }
    
    func getData() {
        if let data = defaults.value(forKey: "user_stats") as? Dictionary<String, Dictionary<String,Any>> {
            print(data)
            let decodedData = self.importData(data: data)
            self.categories = decodedData
        }
    }
    
    func exportData() -> Dictionary<String, Dictionary<String, Any>> {
        var finalData:Dictionary<String, Dictionary<String, Any>> = [:]
        
        for (key,value) in self.categories {
            var innerArr:Dictionary<String, Any> = [:]
            let items = value.getData()
            for (innerKey, item) in items {
                print(innerKey, item)
                innerArr[innerKey] = item
            }
            
            finalData[key] = innerArr
        }
        
        return finalData
    }
    
    func importData(data:Dictionary<String, Dictionary<String, Any>>) -> Dictionary<String, CategoryStats> {
        var finalData:Dictionary<String, CategoryStats> = [:]
        for (key, value) in data {
            finalData[key] = CategoryStats(type: value["type"] as! String, total: (value["total"] as! Int), wins: value["wins"] as! Int, percentage: value["percentage"] as! Int)
        }
        
        return finalData
    }
    
    func getCategoriesAsArray() -> Array<CategoryStats> {
        var arr:Array<CategoryStats> = []
        for (_, item) in self.categories {
            arr.append(item)
        }
        
        return arr
    }
    
    // Group Session Utils
    
    func saveGroupSession(wTeamPos:MazeLocation, bTeamPos:MazeLocation, currentTeamTurn:TeamTurn, wTeamKeys:Int, bTeamKeys:Int) {
        let gsession = GroupSession(wTeamPos: wTeamPos, bTeamPos: bTeamPos, currentTeamTurn: currentTeamTurn, wTeamKeys: wTeamKeys, bTeamKeys: bTeamKeys).exportToDictionary()
        defaults.setValue(gsession, forKey: "group_session")
    }
    
    /**
     
     */
    func loadGroupSession() -> GroupSession? {
        if let data = defaults.value(forKey: "group_session") as? Dictionary<String, Any> {
            print(data)
            let decodedData:GroupSession = self.importSessionData(data: data)
            return decodedData
        }
        else {
            return nil
        }
    }
    
    func importSessionData(data: Dictionary<String, Any>) -> GroupSession {
        let wTeamPos:Dictionary<String,Int> = data["whiteTeamPosition"] as! Dictionary<String, Int>
        let bTeamPos:Dictionary<String, Int> = data["blackTeamPosition"] as! Dictionary<String, Int>
        return GroupSession(wTeamPos: MazeLocation(row: wTeamPos["row"]!, col: wTeamPos["col"]!),
                            bTeamPos: MazeLocation(row: bTeamPos["row"]!, col: bTeamPos["col"]!),
                            currentTeamTurn: TeamTurn(rawValue: data["currentTeamTurn"] as! String)!,
                            wTeamKeys: data["whiteTeamKeys"] as! Int,
                            bTeamKeys: data["blackTeamKeys"] as! Int)
    }
    
    func getGroupSession() {
        
    }
    
    // Prevent non singleton access.
    private init(){
        getData()
        loadSettings()
        _ = getProfileImgURL()
        //storeData()
    }
}
