//
//  Stats.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 29/12/20.
//

import Foundation
import SwiftUI


struct Stats:View {
    @Binding var activeView:PushedItem?
    @ObservedObject var userprogress = User.shared
    let dictionarySorted = User.shared.categories.sorted(by: { $0.key < $1.key })
    let categoriesArr = User.shared.getCategoriesAsArray()
    var slides = ["General", "Film", "TV", "Science","Geography","History","Sports","Celebrity","Computer"]
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack {
                BackArrowWithoutTimer()
                VStack {
                    CustomText(text: "All time Stats", size: 24.0, color: .white).padding(.bottom, 20)
                    
                    ScrollView{
                        VStack(spacing: 20){
                            ForEach(0..<slides.count, id: \.self) { index in
                                VStack(spacing: 10){
                                    HStack{
                                        CustomText(text: self.slides[index], size: 18, color: .white)
                                        Spacer()
                                    }.frame(width: 345, height: 20, alignment: .center)
                                    StatsBox(percentage: CGFloat((userprogress.categories[self.slides[index].lowercased()]?.percentage ?? 0)/100), colorIndex: index)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
