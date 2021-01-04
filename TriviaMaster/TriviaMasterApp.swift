//
//  TriviaMasterApp.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 19/12/20.
//

import UIKit
import SwiftUI
import SDWebImage
import SDWebImageSVGCoder
import SDWebImageSwiftUI

class NavigationHelper: ObservableObject {
    @Published var selection: String? = nil
}

class LayoutVariables: ObservableObject {
    @Published var showTabBar:Bool = true
}

@main
struct TriviaMasterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(NavigationHelper()).environmentObject(LayoutVariables())
        }
    }
}
