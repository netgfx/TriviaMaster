//
//  ContentView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 19/12/20.
//

import SwiftUI
import SDWebImage
import SDWebImageSVGCoder
import SDWebImageSwiftUI
import NavigationStack

var greenColor = SwiftUI.Color.init(red: 141/255, green: 188/255, blue: 39/255)
var greyColor = SwiftUI.Color.init(red: 233/255, green: 233/255, blue: 233/255)
var yellowColor = SwiftUI.Color.init(red: 235/255, green: 208/255, blue: 41/255)
var goldColor = SwiftUI.Color.init(red: 185/255, green: 163/255, blue: 0/255)
var pinkColor = SwiftUI.Color.init(red: 220/255, green: 60/255, blue: 96/255)
var purpleColor = SwiftUI.Color.init(red: 191/255, green: 79/255, blue: 151/255)
var blueColor = SwiftUI.Color.init(red: 0/255, green: 211/255, blue: 255/255)
var lightGreenColor = SwiftUI.Color.init(red: 155/255, green: 222/255, blue: 172/255)
var orangeColor = SwiftUI.Color.init(red: 227/255, green: 56/255, blue: 40/255)
var palePink = SwiftUI.Color.init(red: 233/255, green: 102/255, blue: 123/255)
var lightPurple = SwiftUI.Color.init(red: 216/255, green: 191/255, blue: 216/255)
var greenBlueColor = SwiftUI.Color.init(red: 0/255, green: 163/0255, blue: 190/255)
var errorRed = SwiftUI.Color.init(red: 222/255, green: 79/255, blue: 91/255)
var correctGreen = SwiftUI.Color.init(red: 126/255, green: 179/255, blue: 86/255)

enum PushedItem: String {
    case REGISTER = "register"
    case MENU = "menu"
    case CATEGORIES = "categories"
    case WHEEL = "wheel"
    case PROFILE_EDITOR = "profile_editor"
    case PROFILE = "profile"
    case STATS = "stats"
    case SETTINGS = "settings"
    case HELP = "help"
}



struct ContentView: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    @EnvironmentObject var layoutVars: LayoutVariables
    @EnvironmentObject private var navigationStack: NavigationStack
    // change this to navigate to a specific view (dev preview mostly)
    @State var selectedPushedItem: PushedItem?
    
    func checkRegistration() {
        selectedPushedItem = User.shared.getName() == "" ? PushedItem.REGISTER : PushedItem.MENU
        
        //print(self.navigationHelper.selection)
    }
    
    var body: some View {
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack{
                NavigationStackView {
                    Router(activeView: $selectedPushedItem)
                    VStack{
                        if User.shared.getName() == "" {
                            LoginView(activeView: $selectedPushedItem)
                        }
                        else {
                            MenuView(activeView: $selectedPushedItem)
                        }
                        
                        Spacer()
                        
                    }
                }
                Spacer()
                
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    //@StateObject private var router = NavigationHelper()
    init(){
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.clear)
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().backgroundColor = .green
        //For other NavigationBar changes, look here:(https://stackoverflow.com/a/57509555/5623035)
    }
    static var previews: some View {
        ContentView()
    }
}
