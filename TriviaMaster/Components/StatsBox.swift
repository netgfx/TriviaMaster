//
//  StatsBox.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 2/1/21.
//

import Foundation
import SwiftUI


struct StatsBox:View {
    
    var percentage:CGFloat = 0
    var colors:Array<Color> = [greenColor, pinkColor, purpleColor, goldColor, lightGreenColor, orangeColor, palePink, lightPurple, greenBlueColor]
    var colorIndex:Int = 0
    
    var body: some View {
        ZStack {
            // white background box
            RoundedRectangle(cornerRadius: 5.0)
                .fill(Color.white).frame(width: 345, height: 30, alignment: .center)
            RoundedRectangle(cornerRadius: 5)
                .fill(colors[colorIndex]).frame(width: 345*percentage, height: 30, alignment: .center)
            HStack {
                Spacer()
                CustomText(text: String(Int(self.percentage)*100)+"%", size: 16, color: .white)
                Spacer()
            }.frame(width: 345*percentage, height: 30, alignment: .center).cornerRadius(5.0)
        }
    }
}
