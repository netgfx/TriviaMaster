//
//  GroupSession.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 27/1/21.
//

import Foundation

class GroupSession {
    var whiteTeamPosition:MazeLocation!
    var blackTeamPosition:MazeLocation!
    var currentTeamTurn: TeamTurn!
    var whiteTeamKeys:Int = 0
    var blackTeamKeys:Int = 0
    
    init(wTeamPos:MazeLocation, bTeamPos:MazeLocation, currentTeamTurn:TeamTurn, wTeamKeys:Int, bTeamKeys:Int) {
        self.whiteTeamKeys = wTeamKeys
        self.blackTeamKeys = bTeamKeys
        self.whiteTeamPosition = wTeamPos
        self.blackTeamPosition = bTeamPos
        self.currentTeamTurn = currentTeamTurn
    }
    
    func exportToDictionary() -> Dictionary<String,Any> {
        return [
            "whiteTeamKeys": self.whiteTeamKeys,
            "blackTeamKeys": self.blackTeamKeys,
            "whiteTeamPosition": ["row": self.whiteTeamPosition.row, "col": self.whiteTeamPosition.col],
            "blackTeamPosition": ["row": self.blackTeamPosition.row, "col": self.blackTeamPosition.col],
            "currentTeamTurn": self.currentTeamTurn.rawValue
        ]
    }
}
