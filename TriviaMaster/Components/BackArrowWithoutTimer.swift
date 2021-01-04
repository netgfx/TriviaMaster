//
//  BackArrowWithoutTimer.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 30/12/20.
//

import Foundation
import SwiftUI
import NavigationStack

struct BackArrowWithoutTimer: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack{
            PopView {
                Image("arrow").resizable().frame(width: 32, height: 32, alignment: .leading).padding()
            }
            Spacer()
        }
    }
}



