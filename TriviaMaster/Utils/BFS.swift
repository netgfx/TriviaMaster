//
//  BFS.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 22/1/21.
//

import Foundation

class BFS {
    var grid:Grid = Grid(width: 8, height: 8)
    init() {
        
    }
    
    func findPath(start:MazeLocation, end: MazeLocation) -> Array<MazeLocation> {
        var openList:Array<GridNode> = []
        let startNode:GridNode = grid.getNodeAt(x: start.row, y: start.col)
        let endNode:GridNode = grid.getNodeAt(x: end.row, y: end.col)
        var neighbors:Array<GridNode> = []
        var neighbor:GridNode!
        var node:GridNode!
        var i = 0
        var l = 0
        
        openList.append(startNode)
        startNode.opened = true
        
        while openList.isEmpty == false {
            node = openList.remove(at: 0)
            startNode.closed = true
            
            print(node.x, node.y," is equal to: ", endNode.x, endNode.y)
            if node === endNode {
                return backtrace(node: endNode)
            }
            
            neighbors = grid.getNeighbors(node: node)
            
            i = 0
            l = neighbors.count
            for _ in i ..< l {
                neighbor = neighbors[i]
                
                if neighbor.closed == true || neighbor.opened == true {
                    i += 1
                    continue
                }
                
                openList.append(neighbor)
                neighbor.opened = true
                neighbor.parent = node
                i += 1
            }
        }
        
        return []
    }
    
    func backtrace(node:GridNode) -> Array<MazeLocation> {
        var _node = node
        var path:Array<MazeLocation> = [MazeLocation(row: _node.x, col: _node.y)]
        while (_node.parent != nil) {
            _node = _node.parent
            path.append(MazeLocation(row: _node.x, col: _node.y))
        }
        return path.reversed()
    }
}
