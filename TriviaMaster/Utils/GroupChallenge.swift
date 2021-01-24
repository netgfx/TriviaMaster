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
    
    var map2D = [
        [1, 1, 1, 5, 1, 1, 1, 5],
        [1, 0, 0, 0, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 0, 0, 1],
        [5, 0, 0, 0, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 5],
        [1, 1, 1, 1, 5, 0, 0, 1],
        [1, 0, 0, 0, 1, 0, 0, 5],
        [5, 1, 1, 1, 1, 1, 5, 2]
    ]
    
    var stepCounter = 0
    var visited:Array<Array<Int>> = [
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
    ]
    
    var currentGoal:MazeLocation = MazeLocation(row: 0, col: 0)
    
    func setCurrentGoal(goal:MazeLocation) {
        self.currentGoal = goal
    }
    
    func getCurrentGoal() -> MazeLocation {
        return self.currentGoal
    }
    
    func getMap() -> Array<Int> {
        return self.map
    }
    
    func getMap2D() -> Array<Array<Int>> {
        return self.map2D
    }
    
    func resetVisited() {
        // also the step counter
        self.stepCounter = 0
        
        var counter = 0
        var innerCounter = 0
        for item in visited {
            for _ in item {
                visited[counter][innerCounter] = 0
                innerCounter += 1
            }
            counter += 1
            innerCounter = 0
        }
    }
    
    func getVisited() -> Array<Array<Int>> {
        return visited
    }
    
    func getVectorTypeBy(point:MazeLocation) -> Cell {
        
        let maxRow = 7
        let maxCol = 7
        
        if point.row < 0 {
            return Cell.NotFound
        }
        
        if point.col < 0 {
            return Cell.NotFound
        }
        
        if point.row > maxRow || point.col > maxCol {
            return Cell.NotFound
        }
        
        if map2D[point.row][point.col] == 0 {
            return Cell.Blocked
        }
        else if map2D[point.row][point.col] == 1 {
            return Cell.Empty
        }
        else if map2D[point.row][point.col] == 2 {
            return Cell.Goal
        }
        else if map2D[point.row][point.col] == 5 {
            return Cell.Key
        }
        else {
            return Cell.NotFound
        }
    }
    
    func isValidBlock(row:Int, col:Int) -> Bool {
        let maxRow = 7
        let maxCol = 7
        let type = self.getVectorTypeBy(point: MazeLocation(row: row, col: col))
        
        if(row<0 || row>maxRow || col<0 || col>maxCol){
            return false
        }
        else{
            print(type)
            if type == Cell.Blocked || type == Cell.NotFound {
                return false
            }
            else {
                // finally
                return true
            }
        }
    }
    
    func floodFill(row:Int, col:Int, step:Int, teamPosition:MazeLocation){
        print("checking: ", row, col)
        if(isValidBlock(row: row, col: col) == false){     //Base case
            return
        }
        
//        if(stepCounter > step){
//            // we walked too far
//            return
//        }
        
        // we already visited that
        if visited[row][col] == 1 || visited[row][col] == 2 {
            return
        }
        
        // moving in the right direction
        //if stepCounter < step {
            stepCounter += 1
            visited[row][col] = 1;
        //}
        
        let distance = PointManhattanDistance(from: MazeLocation(row: row, col: col), to: teamPosition)
        print("Distance: ", distance)
        if(distance == step){
            
            print("adding one for step counter: ", stepCounter)
            //Current node is marked as visited.
            // check if path contains valid number of steps, we use DFS for this
            
            visited[row][col] = 2;
           
            stepCounter = 0
            
            print("same as step this is the solution: ",row, col)
        }
        
        floodFill(row: row-1, col: col, step: step, teamPosition: teamPosition);
        floodFill(row: row+1, col: col, step: step, teamPosition: teamPosition);
        floodFill(row: row, col: col-1, step: step, teamPosition: teamPosition);
        floodFill(row: row, col: col+1, step: step, teamPosition: teamPosition);
        
        // no diagonal checking
        //floodFill(i-1,j-1,idxValue);
        //floodFill(i-1,j+1,idxValue);
        //floodFill(i+1,j-1,idxValue);
        //floodFill(i+1,j+1,idxValue);
    }
    
    func PointDistanceSquared(from: MazeLocation, to: MazeLocation) -> Int {
        let subRow = (from.row - to.row) * (from.row - to.row)
        let subCol = (from.col - to.col) * (from.col - to.col)
        return subRow + subCol
    }

    func PointManhattanDistance(from: MazeLocation, to: MazeLocation) -> Int {
        return (abs(from.row - to.row) + abs(from.col - to.col))
    }
    
    func calculateMaze(start:MazeLocation, goal:MazeLocation = MazeLocation(row: 0, col: 0), limit:Int) -> Bool {
        let maze = self.getMaze()
        
        let successors = successorsForMaze(maze)
        if let solution = dfs(initialState: start, goal: goal, goalTestFn: goalTest, successorFn: successors) {
            let path = nodeToPath(solution)
            print("This path contains \(path.count) steps, limit is \(limit)")
            //markMaze(&maze, path: path, start: start, goal: goal)
            //printMaze(maze)
            if path.count-1 > limit {
                return false
            }
            else if path.count-1 == limit {
                return true
            }
            else {
                return false
            }
        }
        else {
            print("nothing")
            return false
        }
    }
    
    func pathContainsBlocked(pointA:MazeLocation, pointB:MazeLocation) -> Bool? {
        var rowBased:Bool = false
        var colBased:Bool = false
        let result:Bool? = nil
        if pointA.row == pointB.row {
            rowBased = true
        }
        else if pointA.col == pointB.col {
            colBased = true
        }
        else {
            // can't make assumption
            return nil
        }
        
        return result
    }
    
    func printMaze(_ maze: Maze) {
        for i in 0..<maze.count {
            let val = maze[i].map{ $0.rawValue }
            print(String(val[0]))
        }
    }
    
    /**
        Deprecated
    */
    func calculateLegalPositions(currentPos:MazeLocation, steps:Int) -> Array<MazeLocation> {
        // rows first
        let maxRow = 7
        let maxCol = 7
        var finalPositions:Array<MazeLocation> = []
        
        // check row
        let rowLeftovers = maxRow - currentPos.row
        print("Left overs and current position: ", rowLeftovers, currentPos, steps)
        // so we have rowLeftovers towards bottom and currentPos.row towards top e.g 3, 0 has 5 slots towards bottom, and 3 towards top
        if currentPos.row + steps <= maxRow {
            // it fits on bottom
            print("it fits in row towards bottom")
            finalPositions.append(MazeLocation(row: currentPos.row+steps, col: currentPos.col))
        }
        else {
            // it doesn't fit so we need to calculate the column spillover
            let leftovers = maxRow - currentPos.row
            let spilloverAmount = steps - leftovers // the amount of extra steps to spillover the column
            
            // calculate col
            //let colLeftOvers = maxCol - currentPos.col
            if currentPos.col + spilloverAmount <= maxCol {
                // it fits towards the right
                print("it fits in row towards right")
                finalPositions.append(MazeLocation(row: maxRow, col: currentPos.col+spilloverAmount))
            }
            
            if currentPos.col - abs(spilloverAmount) >= 0 {
                // it also fits towards the left
                print("it fits in row towards left")
                finalPositions.append(MazeLocation(row: maxRow, col: currentPos.col - abs(spilloverAmount)))
            }
        }
        
        if currentPos.row - steps >= 0 {
            // it fits on top
            print("it fits in row towards top")
            finalPositions.append(MazeLocation(row: currentPos.row-steps, col: currentPos.col))
        }
        else {
            // it doesn't fit so we need to calculate the column spillover
            let leftovers = maxRow - currentPos.row
            let spilloverAmount = steps - leftovers // the amount of extra steps to spillover the column
            
            // calculate col
            //let colLeftOvers = maxCol - currentPos.col
            if currentPos.col + spilloverAmount <= maxCol {
                // it fits towards the right
                print("it fits in row towards right")
                finalPositions.append(MazeLocation(row: maxRow, col: currentPos.col+spilloverAmount))
            }
            
            if currentPos.col - abs(spilloverAmount) >= 0 {
                // it also fits towards the left
                print("it fits in row towards left")
                finalPositions.append(MazeLocation(row: maxRow, col: currentPos.col - abs(spilloverAmount)))
            }
        }
        
        // end of rows ^v
        
        if currentPos.col + steps <= maxCol {
            // it fits on bottom
            print("it fits in column right")
            finalPositions.append(MazeLocation(row: currentPos.row, col: currentPos.col+steps))
        }
        else {
            // it doesn't fit so we need to calculate the column spillover
            let leftovers = maxCol - currentPos.col
            let spilloverAmount = steps - leftovers // the amount of extra steps to spillover the column
            
            // calculate col
            //let colLeftOvers = maxCol - currentPos.col
            if currentPos.row + spilloverAmount <= maxRow {
                // it fits towards the right
                print("it fits in column towards bottom ", spilloverAmount)
                finalPositions.append(MazeLocation(row: currentPos.row+spilloverAmount, col: maxCol))
            }
            
            if currentPos.row - abs(spilloverAmount) >= 0 {
                // it also fits towards the left
                print("it fits in column towards top ", spilloverAmount)
                finalPositions.append(MazeLocation(row: currentPos.row - abs(spilloverAmount), col: maxCol))
            }
        }
        
        if currentPos.col - steps >= 0 {
            // it fits on top
            print("it fits in column left")
            finalPositions.append(MazeLocation(row: currentPos.row, col: currentPos.col-steps))
        }
        else {
            // it doesn't fit so we need to calculate the column spillover
            let leftovers = maxCol - currentPos.col
            let spilloverAmount = steps - leftovers // the amount of extra steps to spillover the column
            
            // calculate col
            //let colLeftOvers = maxCol - currentPos.col
            if currentPos.row + spilloverAmount <= maxRow {
                // it fits towards the right
                print("it fits in column top towards bottom ", spilloverAmount)
                finalPositions.append(MazeLocation(row: currentPos.row + spilloverAmount, col: maxCol))
            }
            
            if currentPos.col - abs(spilloverAmount) >= 0 {
                // it also fits towards the left
                print("it fits in column top towards top ", spilloverAmount)
                finalPositions.append(MazeLocation(row: currentPos.row - abs(spilloverAmount), col: maxCol))
            }
            
        }
        
        
        return finalPositions
        
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
