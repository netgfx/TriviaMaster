//
//  Utils.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 29/12/20.
//

import Foundation
import Repeat
import SwiftUI

class Utils: ObservableObject {
    static let shared = Utils()
    var currentTime:Int64 = 0
    var timer:Repeater!
    @Published var elapsedTime:Int = 30
    @Published var ended:Bool = false
    
    func setCurrentTime() {
        self.ended = false
        self.elapsedTime = 30
        currentTime = Date().toMillis()
    }
    
    // in seconds
    func getElapsedTime() -> Int64 {
        if let now = Date().toMillis() {
            return (now - currentTime) / 1000
        }
        else {
            return 0
        }
    }
    
    func startTimer() {
        self.ended = false
        if self.timer == nil {
            self.timer = Repeater.every(.seconds(1), count: 30) { timer  in
                
                if Date().toMillis() != nil {
                    DispatchQueue.main.sync {
                        print(self.getElapsedTime())
                        self.elapsedTime = 30 - Int(self.getElapsedTime())
                        if self.elapsedTime <= 0 && self.ended == false {
                            self.ended = true
                            print("ended!")
                        }
                    }
                }
            }
        }
        else {
            self.setCurrentTime()
            self.timer.reset(.seconds(1.0), restart: true)
        }
    }
    
    func stopTimer() {
        self.timer.pause()
        //self.elapsedTime = 30
    }
    
    private init() { }
}
