//
//  GridNode.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 22/1/21.
//

import Foundation

class GridNode {
    var x:Int = 0
    var y:Int = 0
    var type:Cell!
    var opened:Bool = false
    var closed:Bool = false
    var parent:GridNode!
    
    init(x:Int, y:Int, type:Cell) {
        self.x = x
        self.y = y
        self.type = type
    }
    
    func getX() -> Int {
        return self.x
    }
    
    func getY() -> Int {
        return self.y
    }
    
    func getType() -> Cell {
        return type ?? .Empty
    }
    
    func getAsML() -> MazeLocation {
        return MazeLocation(row: x, col: y)
    }
}
