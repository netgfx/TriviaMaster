//
//  BackArrow.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 23/12/20.
//

import Foundation
import SwiftUI
import NavigationStack

struct BackArrow: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var elapsedTime:Int
    var showTime:Bool = false
    
    var body: some View {
        HStack{
            PopView {
                Image("arrow").resizable().frame(width: 32, height: 32, alignment: .leading).padding()
            }
            Spacer()
            if showTime == true {
                if let _elapsedTime = elapsedTime {
                    HStack(spacing:10) {
                        Image("timer").resizable().frame(width: 36, height: 36, alignment: .center)
                        Text(String(_elapsedTime)+"s").font(.custom("KGBlankSpaceSolid", size: 18)).foregroundColor(.white).padding(.trailing, 20)
                    }
                }
            }
        }
    }
}



