//
//  Router.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 28/12/20.
//

import Foundation
import SwiftUI
import NavigationStack

struct Router:View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var activeView: PushedItem?
    var body: some View {
        ZStack{
            PushView(destination: UserProfile(activeView: $activeView), destinationId: PushedItem.PROFILE.rawValue, tag: PushedItem.PROFILE, selection: $activeView){ EmptyView() }
            PushView(destination: Categories(activeView: $activeView), destinationId: PushedItem.CATEGORIES.rawValue, tag: PushedItem.CATEGORIES, selection: $activeView) { EmptyView() }
            PushView(destination: Stats(activeView: $activeView), destinationId: PushedItem.STATS.rawValue, tag: PushedItem.STATS, selection: $activeView) { EmptyView() }
            PushView(destination: Help(activeView: $activeView), destinationId: PushedItem.HELP.rawValue, tag: PushedItem.HELP, selection: $activeView) { EmptyView() }
            PushView(destination: Settings(activeView: $activeView), destinationId: PushedItem.SETTINGS.rawValue, tag: PushedItem.SETTINGS, selection: $activeView) { EmptyView() }
            PushView(destination: MenuView(activeView: $activeView), destinationId: PushedItem.MENU.rawValue, tag: PushedItem.MENU, selection: $activeView){ EmptyView() }
            PushView(destination: LoginView(activeView: $activeView), destinationId: PushedItem.REGISTER.rawValue, tag: PushedItem.REGISTER, selection: $activeView){ EmptyView() }
        }
    }
}
