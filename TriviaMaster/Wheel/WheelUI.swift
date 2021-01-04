//
//  WheelUI.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 19/12/20.
//

import Foundation
import SwiftUI
import Combine

struct WheelUIView: View {
    @State private var currentIndex: Int = 0
    @Binding var slides:Array<String>
    @Binding var slicePicked:Bool
    @Binding var sliceIndexPicked:Int

    var body: some View {
        WheelView(slides: slides, slicePicked: $slicePicked, sliceIndexPicked: $sliceIndexPicked)
    }
}
