//
//  Stack.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 5/1/21.
//

import Foundation

public class Stack<T> {
     private var container: [T] = [T]()
     public var isEmpty: Bool { return container.isEmpty }
     public func push(thing: T) { container.append(thing) }
     public func pop() -> T { return container.removeLast() }
 }
