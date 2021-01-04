//
//  CategoryBox.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 23/12/20.
//

import Foundation
import SwiftUI

struct CategoryBox:View {
    
    @ObservedObject var userprogress = User.shared
    var showPercentage:Bool = true
    var category:String = "general"
    var categoryName:String
    var colors = [greenColor, pinkColor, purpleColor, goldColor, lightGreenColor, orangeColor, palePink, lightPurple, greenBlueColor]
    var colorIndex:Int
    func getPercent(value:Int) -> String {
        return String(value)+"%"
    }
    
    var body: some View {
        
                VStack(spacing: 5){
                    ZStack{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(colors[colorIndex])
                                        .frame(width: 82, height: 82)
                        VStack(spacing: 10){
                            Image(category).resizable().frame(width: 42, height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.top, 5)
                            Text(categoryName).font(.custom("KGBlankSpaceSolid", size: 12)).foregroundColor(greyColor).padding(.bottom, 5)
                        }
                    }
                    if showPercentage == true {
                        Text(getPercent(value: userprogress.categories[category]?.percentage ?? 0)).font(.custom("KGBlankSpaceSolid", size: 18)).foregroundColor(.white)
                    }
                }
            }
}
