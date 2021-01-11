//
//  DiceWheel.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 10/1/21.
//


import Foundation
import UIKit
import SwiftUI
import SwiftFortuneWheel

struct DiceWheelView: UIViewRepresentable {
    
    var nums:Array<String> = ["1", "2", "3", "4", "5", "6"]
    //@Binding var mazeHelper:MazeHelper
//    @Binding var slicePicked:Bool
//    @Binding var sliceIndexPicked:Int
    
    init() {
        
        //self._mazeHelper = mazeHelper
//        self._slicePicked = slicePicked
//        self._sliceIndexPicked = sliceIndexPicked
    }
    
     func getSlices() -> [Slice]{
        var slices: [Slice] = []
        for index in 0...nums.count-1 {
            let headerContent = Slice.ContentType.text(text: String((nums[index])), preferences: .diceTextPreferences)
            let descriptionContent = Slice.ContentType.text(text: "MOVE", preferences: .diceDescriptionTextPreferences)
                    //Slice.ContentType.assetImage(name: slides[index].lowercased(), preferences: .prizeImagePreferences)
                    //
                let slice = Slice(contents: [headerContent])
                slices.append(slice)
            }
            return slices
    }
    
    func getFortuneWheel() -> SwiftFortuneWheel {
        let slices:[Slice] = getSlices()
        let frame = CGRect(x: 0, y: 0, width: 110, height: 110)
        let fortuneWheel = SwiftFortuneWheel(frame: frame, slices: slices, configuration: .DiceWheelConfiguration)
        DispatchQueue.main.async {
            fortuneWheel.addTapGestureRecognizer{
                handleTap(fortuneWheel: fortuneWheel)
            }
        }
        return fortuneWheel
    }

//    var fortuneWheel: SwiftFortuneWheel = {
//        //var slices = getSlices()
//        let frame = CGRect(x: 35, y: 100, width: 300, height: 300)
//        let fortuneWheel = SwiftFortuneWheel(frame: frame, slices: getSlices(), configuration: .withoutStoryboardExampleConfiguration)
//
//            return fortuneWheel
//        }()
   
    
    func getSliceCount() -> Int {
        return getSlices().count
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> UIView {
        let pageViewController:UIView = UIView()
        let fortuneWheel:SwiftFortuneWheel = getFortuneWheel()
        DispatchQueue.main.async {
            pageViewController.addSubview(fortuneWheel)
        }
        
        return pageViewController
    }
    
    func handleTap(fortuneWheel:SwiftFortuneWheel){
        print("tapped")
        let index = Int.random(in: 0..<getSliceCount())
        fortuneWheel.startRotationAnimation(finishIndex: index, continuousRotationTime: 1) { result in
            print("done")
            MazeHelper.shared.calculateTiles(wheelResult: Int(index))
            //self.sliceIndexPicked = index
            //self.slicePicked = true
            
        }
    }
    
}

