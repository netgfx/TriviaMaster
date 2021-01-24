//
//  Grid.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 22/1/21.
//

import Foundation

class Grid {
    var width:Int = 0
    var height:Int = 0
    var matrix:Array<Array<GridNode>> = []
    
    init(width:Int, height:Int) {
        self.width = width
        self.height = height
        
        self.matrix = self.createMatrix()
    }
    
    func createMatrix() ->Array<Array<GridNode>> {
        var finalResult:Array<Array<GridNode>> = []
        
        let blocks = GroupChallenge()
        let maze = blocks.getMap2D()
        
        for index in 0..<maze.count {
            finalResult.append([])
            for innerIndex in 0..<maze[index].count {
                let type = blocks.getVectorTypeBy(point: MazeLocation(row: index, col: innerIndex))
                finalResult[index].append(GridNode(x: index, y: innerIndex, type: type))
            }
        }
        
        return finalResult
    }
    
    func isWalkableAt(x:Int, y:Int) -> Bool {
        return self.isInside(x: x, y: y) && self.matrix[x][y].getType() != .Blocked;
    }
    
    func isInside(x:Int, y:Int) -> Bool {
        return (x >= 0 && x < self.width) && (y >= 0 && y < self.height)
    }
    
    func getNodeAt(x:Int, y:Int) -> GridNode {
        return matrix[x][y]
    }
    
    func getNeighbors(node:GridNode) -> Array<GridNode> {
        let x = node.getX()
        let y = node.getY()
        var neighbors:Array<GridNode> = []
        
        // ↑
        if (self.isWalkableAt(x: x-1, y: y)) {
            neighbors.append(matrix[x-1][y]);
        }
        // →
        if (self.isWalkableAt(x:x, y:y+1)) {
            neighbors.append(matrix[x][y + 1]);
        }
        // ↓
        if (self.isWalkableAt(x:x+1, y:y)) {
            neighbors.append(matrix[x+1][y]);
            
        }
        // ←
        if (self.isWalkableAt(x: x, y:y-1)) {
            neighbors.append(matrix[x][y - 1]);
        }
        
        return neighbors
    }
}
