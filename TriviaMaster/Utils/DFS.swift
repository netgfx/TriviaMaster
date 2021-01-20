//
//  DFS.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 5/1/21.
//

import Foundation


func dfs<StateType: Hashable>(initialState: StateType, goal:MazeLocation, goalTestFn: (StateType, MazeLocation) -> Bool, successorFn: (StateType) -> [StateType]) -> Node<StateType>? {
    // frontier is where we've yet to go
    let frontier: Stack<Node<StateType>> = Stack<Node<StateType>>()
    frontier.push(thing: Node(state: initialState, parent: nil))
    // explored is where we've been
    var explored: Set<StateType> = Set<StateType>()
    explored.insert(initialState)
    // keep going while there is more to explore
    while !frontier.isEmpty {
        let currentNode = frontier.pop()
        let currentState = currentNode.state
        // if we found the goal, we're done
        if goalTestFn(currentState, goal) { return currentNode }
        // check where we can go next and haven't explored
        for child in successorFn(currentState) where !explored.contains(child) {
            explored.insert(child)
            frontier.push(thing: Node(state: child, parent: currentNode))
        }
    }
    return nil // never found the goal
}

func nodeToPath<StateType>(_ node: Node<StateType>) -> [StateType] {
    var path: [StateType] = [node.state]
    var currentNode = node.parent
    // work backwards from end to front
    while currentNode != nil {
        path.insert(currentNode!.state, at: 0)
        currentNode = currentNode?.parent
    }
    return path
}

struct MazeLocation: Hashable {
    let row: Int
    let col: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(row.hashValue ^ col.hashValue)
    }
    var hashValue: Int { return row.hashValue ^ col.hashValue }
}

func == (lhs: MazeLocation, rhs: MazeLocation) -> Bool {
    return lhs.row == rhs.row && lhs.col == rhs.col
}

enum Cell: Int {
    case Empty = 1
    case Blocked = 0
    case Key = 5
    case Goal = 2
    case NotFound = -1
}

typealias Maze = [[Cell]]

func successorsForMaze(_ maze: Maze) -> (MazeLocation) -> [MazeLocation] {
    func successors(ml: MazeLocation) -> [MazeLocation] { //no diagonals
        var newMLs: [MazeLocation] = [MazeLocation]()
        if (ml.row + 1 < maze.count) && (maze[ml.row + 1][ml.col] != .Blocked) {
            newMLs.append(MazeLocation(row: ml.row + 1, col: ml.col))
        }
        if (ml.row - 1 >= 0) && (maze[ml.row - 1][ml.col] != .Blocked) {
            newMLs.append(MazeLocation(row: ml.row - 1, col: ml.col))
        }
        if (ml.col + 1 < maze[0].count) && (maze[ml.row][ml.col + 1] != .Blocked) {
            newMLs.append(MazeLocation(row: ml.row, col: ml.col + 1))
        }
        if (ml.col - 1 >= 0) && (maze[ml.row][ml.col - 1] != .Blocked) {
            newMLs.append(MazeLocation(row: ml.row, col: ml.col - 1))
        }
        
        return newMLs
    }
    return successors
}

func goalTest(ml: MazeLocation, goal:MazeLocation) -> Bool {
    //let blocks = GroupChallenge()
    //let _goal = blocks.getCurrentGoal()
    return ml == goal
}
