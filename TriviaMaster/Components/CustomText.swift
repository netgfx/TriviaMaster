//
//  CustomText.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 2/1/21.
//

import Foundation
import SwiftUI


struct CustomText:View {
    var text:String
    var size:CGFloat
    var color:Color
    
    var body: some View {
        Text(self.text).font(.custom("KGBlankSpaceSolid", size: self.size)).foregroundColor(self.color)
    }
}
