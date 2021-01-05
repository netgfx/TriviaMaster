//
//  Node.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 5/1/21.
//

import Foundation

class Node<T>: Comparable, Hashable {
     let state: T
     let parent: Node?
     let cost: Float
     let heuristic: Float
     init(state: T, parent: Node?, cost: Float = 0.0, heuristic: Float = 0.0) {
         self.state = state
         self.parent = parent
         self.cost = cost
         self.heuristic = heuristic
     }
  
    func hash(into hasher: inout Hasher) {
        hasher.combine(cost+heuristic)
    }
    
     var hashValue: Int { return (Int) (cost + heuristic) }
 }
  
 func < <T>(lhs: Node<T>, rhs: Node<T>) -> Bool {
     return (lhs.cost + lhs.heuristic) < (rhs.cost + rhs.heuristic)
 }
  
 func == <T>(lhs: Node<T>, rhs: Node<T>) -> Bool {
     return lhs === rhs
 }
