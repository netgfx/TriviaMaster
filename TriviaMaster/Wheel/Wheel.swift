//
//  Wheel.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 19/12/20.
//

import Foundation
import UIKit
import SwiftUI
import SwiftFortuneWheel

struct WheelView: UIViewRepresentable {
    
    var slides:Array<String>
    @Binding var slicePicked:Bool
    @Binding var sliceIndexPicked:Int
    
    init(slides:Array<String>, slicePicked:Binding<Bool>, sliceIndexPicked:Binding<Int>) {
        self.slides = slides
        
        self._slicePicked = slicePicked
        self._sliceIndexPicked = sliceIndexPicked
    }
    
     func getSlices() -> [Slice]{
            var slices: [Slice] = []
        for index in 0...slides.count-1 {
                print("slide: ", slides[index])
                let headerContent = Slice.ContentType.text(text: "\(slides[index])", preferences: .withoutStoryboardExampleDescriptionTextPreferences)
                let descriptionContent = Slice.ContentType.assetImage(name: slides[index].lowercased(), preferences: .prizeImagePreferences)
                    //Slice.ContentType.text(text: "DESCRIPTION", preferences: .withoutStoryboardExampleDescriptionTextPreferences)
                let slice = Slice(contents: [headerContent , descriptionContent])
                slices.append(slice)
            }
            return slices
    }
    
    func getFortuneWheel() -> SwiftFortuneWheel {
        let slices = getSlices()
        let frame = CGRect(x: 35, y: 100, width: 300, height: 300)
        let fortuneWheel = SwiftFortuneWheel(frame: frame, slices: slices, configuration: .WheelConfiguration)
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
        let fortuneWheel = getFortuneWheel()
        DispatchQueue.main.async {
            pageViewController.addSubview(fortuneWheel)
        }
        
        return pageViewController
    }
    
    func handleTap(fortuneWheel:SwiftFortuneWheel){
        print("tapped")
        let index = Int.random(in: 0..<getSliceCount())
        fortuneWheel.startRotationAnimation(finishIndex: index, continuousRotationTime: 4) { result in
            print("done")
            self.sliceIndexPicked = index
            self.slicePicked = true
            
        }
    }
    
}
