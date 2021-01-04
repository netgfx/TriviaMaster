//
//  ProfileEditor.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 21/12/20.
//

import Foundation
import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageSVGCoder



struct ProfileEditor: View {
    
    @Binding var activeView: PushedItem?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var imgurl:String = ""
    @State private var selectedTopType:Int = 0
    @State private var selectedHatColorType = 0
    @State private var selectedAccessoryType = 0
    @State private var selectedHairColorType = 0
    @State private var selectedFacialHairType = 0
    @State private var selectedClothesType = 1
    @State private var selectedEyeType = 2
    @State private var selectedEybrowType = 0
    @State private var selectedMouthType = 0
    @State private var selectedSkinColorType = 0
    
    @State private var svgdata:String = String()
    @State private var url:String = "" {
        willSet{
                print("willSet")
            }
            didSet{
                fetchSVG()
                //Write code, function do what ever you want todo
            }
    }
    var topFields = TopFields().getValues()
    var hatColors = HatColors().getValues()
    var accessories = Accessories().getValues()
    var hairColors = HairColor().getValues()
    var facialHair = FacialHairType().getValues()
    var clothes = ClothesType().getValues()
    var eyeTypes = EyeType().getValues()
    var eyebrowTypes = EyebrowType().getValues()
    var mouthTypes = MouthType().getValues()
    var skinColors = SkinColor().getValues()
    
    func fetchSVG() {
        if let _url = URL(string: url){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: _url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    //print(String(decoding: data!, as: UTF8.self))
                    svgdata = String(decoding: data!, as: UTF8.self)
                    print(svgdata)
                }
            }
        }
    }
    
    func changeURL() {
        
        var newURL = ""
        newURL = "https://avataaars.io/?avatarStyle=Transparent&topType=\(topFields[selectedTopType])&accessoriesType=\(accessories[selectedAccessoryType])&hatColor=\(hatColors[selectedHatColorType])&facialHairType=\(facialHair[selectedFacialHairType])&facialHairColor=\(hairColors[selectedHairColorType])&clotheType=\(clothes[selectedClothesType])&eyeType=\(eyeTypes[selectedEyeType])&eyebrowType=\(eyebrowTypes[selectedEybrowType])&mouthType=\(mouthTypes[selectedMouthType])&skinColor=\(skinColors[selectedSkinColorType])"
        
        if url != newURL {
            DispatchQueue.global().async {
                url =  "https://avataaars.io/?avatarStyle=Transparent&topType=\(topFields[selectedTopType])&accessoriesType=\(accessories[selectedAccessoryType])&hatColor=\(hatColors[selectedHatColorType])&facialHairType=\(facialHair[selectedFacialHairType])&facialHairColor=\(hairColors[selectedHairColorType])&clotheType=\(clothes[selectedClothesType])&eyeType=\(eyeTypes[selectedEyeType])&eyebrowType=\(eyebrowTypes[selectedEybrowType])&mouthType=\(mouthTypes[selectedMouthType])&skinColor=\(skinColors[selectedSkinColorType])"
            }
        }
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
    
    var baseURL: String = "https://avataaars.io/?avatarStyle=Circle"
    var body: some View {
        
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack {
            HStack{
            Button(action: {
                    print("Dismiss")
                       self.presentationMode.wrappedValue.dismiss()
                    }) {
                Image("arrow").resizable().frame(width: 32, height: 32, alignment: .leading).padding()
                    }
                Spacer()
            }.navigationBarHidden(true)
            //ScrollView(.vertical){
            VStack(spacing: 20){
                HStack{
                    Spacer()
                    ZStack{
                        ZStack{
                            Circle().fill().foregroundColor(.white).frame(width: 114, height: 114, alignment: .center)
                                    
                            Circle()
                                .strokeBorder(Color.red, lineWidth: 4).frame(width: 120, height: 120, alignment: .center)
                            }
                    calculateURL() // Fade Transition with duration
                        .offset(x: 0, y: -8)
                        .frame(width: 88, height: 88, alignment: .center)
                        .foregroundColor(.white)
                                .padding()
                                .clipped()
                        .onAppear(perform:changeURL)
                    }
                    Spacer()
                }
                
                Form {
                    
                    Section {
                        Picker(selection: $selectedTopType, label: Text("Top Type")) {
                            ForEach(0 ..< self.topFields.count) {
                                Text(self.topFields[$0])
                            }
                        }
                    }.listRowBackground(Color.clear)

                    Section {
                        Picker(selection: $selectedAccessoryType, label: Text("Accessory Type")) {
                            ForEach(0 ..< self.accessories.count) {
                                Text(self.accessories[$0])
                            }
                        }
                    }

                    Section {
                        Picker(selection: $selectedHairColorType, label: Text("Hair Color")) {
                            ForEach(0 ..< self.hairColors.count) {
                                Text(self.hairColors[$0])
                            }
                        }
                    }

                    Section {
                        Picker(selection: $selectedFacialHairType, label: Text("Facial Hair")) {
                            ForEach(0 ..< self.facialHair.count) {
                                Text(self.facialHair[$0])
                            }
                        }
                    }

                    Section {
                        Picker(selection: $selectedClothesType, label: Text("Clothes")) {
                            ForEach(0 ..< self.clothes.count) {
                                Text(self.clothes[$0])
                            }
                        }
                    }

                    Section {
                        Picker(selection: $selectedEyeType, label: Text("Eyes")) {
                            ForEach(0 ..< self.eyeTypes.count) {
                                Text(self.eyeTypes[$0])
                            }
                        }
                    }

                    Section {
                        Picker(selection: $selectedEybrowType, label: Text("Eyebrows")) {
                            ForEach(0 ..< self.eyebrowTypes.count) {
                                Text(self.eyebrowTypes[$0])
                            }
                        }
                    }

                    Section {
                        Picker(selection: $selectedMouthType, label: Text("Mouth Type")) {
                            ForEach(0 ..< self.mouthTypes.count) {
                                Text(self.mouthTypes[$0])
                            }
                        }
                    }

                    Section {
                        Picker(selection: $selectedSkinColorType, label: Text("Skin Color")) {
                            ForEach(0 ..< self.skinColors.count) {
                                Text(self.skinColors[$0])
                            }
                        }
                    }
                }.onAppear {
                    UITableView.appearance().backgroundColor = .clear
                 }.background(SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all))
            }
        }
            //}
        }
    }
}
