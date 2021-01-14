//
//  SimpleProfileImage.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 14/1/21.
//

import Foundation
import SwiftUI
import Combine
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageSVGCoder
import NavigationStack

struct SimpleProfileImage:View {

    @Binding var completeURL:String
    var baseURL: String = "https://avatars.dicebear.com/4.5/api/"
    @State private var url:String = User.shared.profileImageURL {
        willSet{
            print("willSet")
        }
        didSet{
            print(User.shared.profileImageURL)
            fetchSVG()
        }
    }
    
    @State private var svgdata:String = String()
    var radius:String = "40"
    
    func fetchSVG() {
        if let _url = URL(string: url){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: _url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    //print(String(decoding: data!, as: UTF8.self))
                    svgdata = String(decoding: data!, as: UTF8.self)
                    if self.url != User.shared.profileImageURL {
                        self.url = User.shared.profileImageURL
                    }
                }
            }
        }
    }
    
    func calculateURL() -> some View {
        if self.url != User.shared.profileImageURL {
            fetchSVG()
        }
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        return SVGUIView(mainStr: $svgdata)
    }
    
    func loadURL() {
        self.url = User.shared.profileImageURL
    }
    
    var body: some View {
        HStack{
            Spacer()
            ZStack{
                ZStack{
                    Circle().fill().foregroundColor(.white).frame(width: 114, height: 114, alignment: .center)
                    
                    Circle()
                        .strokeBorder(greenBlueColor, lineWidth: 4).frame(width: 120, height: 120, alignment: .center)
                }
                if self.url != "" {
                    calculateURL() // Fade Transition with duration
                        .offset(x: 0, y: 0)
                        .frame(width: 88, height: 88, alignment: .center)
                        .foregroundColor(.white)
                        .padding()
                        .clipped()
                }
            }
            Spacer()
        }.onAppear(perform: loadURL)
    }
    
}
