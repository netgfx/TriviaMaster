//
//  ProfileImage.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 13/1/21.
//

import Foundation
import SwiftUI
import Combine
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageSVGCoder
import NavigationStack

struct ProfileImage:View {
    
    @Binding var mood:Array<String>
    @Binding var gender:Array<String>
    @Binding var selectedMood:Int
    @Binding var selectedType:Int
    @Binding var randomSeed:String
    
    @State private var url:String = "" {
        willSet{
            print("willSet")
        }
        didSet{
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
                }
            }
        }
    }
    
    func changeURL() {
        
        var newURL = ""
        newURL = "\(self.baseURL)\(gender[selectedType])/\(randomSeed).svg?r=\(radius)&mood[]=\(mood[selectedMood])"
        //            "https://avataaars.io/?avatarStyle=Transparent&topType=\(topFields[selectedTopType])&accessoriesType=\(accessories[selectedAccessoryType])&hatColor=\(hatColors[selectedHatColorType])&facialHairType=\(facialHair[selectedFacialHairType])&facialHairColor=\(hairColors[selectedHairColorType])&clotheType=\(clothes[selectedClothesType])&eyeType=\(eyeTypes[selectedEyeType])&eyebrowType=\(eyebrowTypes[selectedEybrowType])&mouthType=\(mouthTypes[selectedMouthType])&skinColor=\(skinColors[selectedSkinColorType])"
        
        if url != newURL {
            DispatchQueue.global().async {
                //randomSeed = randomString(length: 100)
                url = "\(self.baseURL)\(gender[selectedType])/\(randomSeed).svg?r=\(radius)&mood[]=\(mood[selectedMood])"
                //                    "https://avataaars.io/?avatarStyle=Transparent&topType=\(topFields[selectedTopType])&accessoriesType=\(accessories[selectedAccessoryType])&hatColor=\(hatColors[selectedHatColorType])&facialHairType=\(facialHair[selectedFacialHairType])&facialHairColor=\(hairColors[selectedHairColorType])&clotheType=\(clothes[selectedClothesType])&eyeType=\(eyeTypes[selectedEyeType])&eyebrowType=\(eyebrowTypes[selectedEybrowType])&mouthType=\(mouthTypes[selectedMouthType])&skinColor=\(skinColors[selectedSkinColorType])"
            }
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func calculateURL() -> some View {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        changeURL()
        return SVGUIView(mainStr: $svgdata)
        //WebView(urlString: url)
        //            AnimatedImage(url: URL(string: svgdata))
        //
        //            // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
        //            .onSuccess { image, data, cacheType in
        //                // Success
        //                // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
        //            }
        //            .onFailure(){error in
        //                print(error)
        //            }
        //            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
        //            .placeholder(PlatformImage(systemName: "user")) // Placeholder Image
        //            // Supports ViewBuilder as well
        //            .placeholder {
        //                Rectangle().foregroundColor(.gray)
        //            }
        //            .indicator(.activity)
    }
    
    var baseURL: String = "https://avatars.dicebear.com/4.5/api/"
    
    var body: some View {
        HStack{
            Spacer()
            ZStack{
                ZStack{
                    Circle().fill().foregroundColor(.white).frame(width: 114, height: 114, alignment: .center)
                    
                    Circle()
                        .strokeBorder(greenBlueColor, lineWidth: 4).frame(width: 120, height: 120, alignment: .center)
                }
                calculateURL() // Fade Transition with duration
                    .offset(x: 0, y: 0)
                    .frame(width: 88, height: 88, alignment: .center)
                    .foregroundColor(.white)
                    .padding()
                    .clipped()
                    .onAppear(perform:changeURL)
            }
            Spacer()
        }
    }
    
}
