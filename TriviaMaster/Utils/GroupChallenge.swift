//
//  GroupChallenge.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 5/1/21.
//

import Foundation
import Combine
import SwiftUI

class GroupChallenge:ObservableObject {
    
    var types = ["general", "film", "tv", "science","geography","history","sports","celebrity","computer"]
    var colors = [greenColor, pinkColor, purpleColor, goldColor, lightGreenColor, orangeColor, palePink, lightPurple, greenBlueColor]
    var map = [
        1, 1, 1, 5, 1, 1, 1, 5,
        1, 0, 0, 0, 1, 0, 0, 1,
        1, 0, 0, 0, 1, 0, 0, 1,
        5, 0, 0, 0, 1, 0, 0, 1,
        1, 0, 0, 0, 1, 1, 1, 5,
        1, 1, 1, 1, 5, 0, 0, 1,
        1, 0, 0, 0, 1, 0, 0, 5,
        5, 1, 1, 1, 1, 1, 5, 2
    ]
    
    func getMap() -> Array<Int> {
        return self.map
    }
    
    func getMaze() -> Maze {
        var maze:Maze = []
        var counter = 0
        for _ in 0..<8 {
            var arr:Array<Cell> = []
            for _ in 0..<8 {
                let item = map[counter]
                var cell:Cell = .Empty
                if item == 0 {
                    cell = .Blocked
                }
                else if item == 1 {
                    cell = .Empty
                }
                else if item == 5 {
                    cell = .Empty
                }
                else if item == 2 {
                    cell = .Goal
                }
                else {
                    cell = .Empty
                }
                arr.append(cell)
                counter += 1
            }
            
            maze.append(arr)
        }
        
        return maze
    }
    
    func getRandomType() -> String {
        // it will never be empty hence the !
        return self.types.shuffled().randomElement()!
    }
    
    func getColor(byCategory:String) -> Color {
        if let index = self.types.firstIndex(of: byCategory) {
            return self.colors[index]
        }
        else {
            return .white
        }
    }
    
}
