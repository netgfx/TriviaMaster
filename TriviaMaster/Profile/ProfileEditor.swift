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
import NavigationStack


struct ProfileEditor: View {
    
    @Binding var activeView: PushedItem?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var profileURL:String = User.shared.profileImageURL
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
    
    //
    @State private var selectedMood = 0
    @State private var selectedType = 0
    
    @State var pickersPresented:Bool = false
    
    
    //    var topFields = TopFields().getValues()
    //    var hatColors = HatColors().getValues()
    //    var accessories = Accessories().getValues()
    //    var hairColors = HairColor().getValues()
    //    var facialHair = FacialHairType().getValues()
    //    var clothes = ClothesType().getValues()
    //    var eyeTypes = EyeType().getValues()
    //    var eyebrowTypes = EyebrowType().getValues()
    //    var mouthTypes = MouthType().getValues()
    //    var skinColors = SkinColor().getValues()
    
    // new avatar //
    @State var gender = GenderFields().getValues()
    @State var mood = MoodFields().getValues()
    @State var randomSeed = "1337"
    
    func toggleCustomizationOptions() {
        self.pickersPresented.toggle()
    }
    
    var body: some View {
        
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack {
                BackArrowWithoutTimer()
                
                VStack(spacing: 20){
                    
                    if profileURL == "" {
                        ProfileImage(mood: $mood, gender: $gender, selectedMood: $selectedMood, selectedType: $selectedType, randomSeed: $randomSeed)
                    }
                    else {
                        SimpleProfileImage(completeURL: $profileURL)
                    }
                    //                    HStack{
                    //                        Spacer()
                    //                        ZStack{
                    //                            ZStack{
                    //                                Circle().fill().foregroundColor(.white).frame(width: 114, height: 114, alignment: .center)
                    //
                    //                                Circle()
                    //                                    .strokeBorder(greenBlueColor, lineWidth: 4).frame(width: 120, height: 120, alignment: .center)
                    //                            }
                    //                            calculateURL() // Fade Transition with duration
                    //                                .offset(x: 0, y: -8)
                    //                                .frame(width: 88, height: 88, alignment: .center)
                    //                                .foregroundColor(.white)
                    //                                .padding()
                    //                                .clipped()
                    //                                .onAppear(perform:changeURL)
                    //                        }
                    //                        Spacer()
                    //                    }
                    
                    Button(action:toggleCustomizationOptions) {
                        CustomText(text: "Customize", size: 18, color: .white)
                    }
                    Spacer()
                    
                }.onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }.background(SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)).sheet(isPresented: $pickersPresented) {
                    PickersView(selectedMood: $selectedMood, selectedType: $selectedType, randomSeed: $randomSeed, mood: self.$mood, gender: self.$gender, pickersPresented: self.$pickersPresented)
                }
            }
            //}
        }
    }
}



struct PickersView:View {
    @Binding var selectedMood:Int
    @Binding var selectedType:Int
    @Binding var randomSeed:String
    @Binding var mood:Array<String>
    @Binding var gender:Array<String>
    @Binding var pickersPresented:Bool
    @State var imageURL:String = User.shared.profileImageURL
    var radius:String = "40"
    var baseURL: String = "https://avatars.dicebear.com/4.5/api/"
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func setRandomSeed() {
        randomSeed = self.randomString(length: 100)
    }
    
    func dismissView() {
        self.pickersPresented.toggle()
    }
    
    func saveImage() {
        User.shared.setProfileImgURL(imgURL: "\(self.baseURL)\(gender[selectedType])/\(randomSeed).svg?r=\(radius)&mood[]=\(mood[selectedMood])")
        self.dismissView()
    }
    
    var body: some View {
        
        ZStack{
            SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Image("fail-particle").resizable().frame(width: 36, height: 36, alignment: .center).padding(.leading, 20).padding(.top, 15)
                    Spacer()
                }.onTapGesture(perform: self.dismissView)
                
                NavigationView {
                    ZStack{
                        SwiftUI.Color.init(red: 133/255, green: 87/255, blue: 160/255, opacity: 1).edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing: 20){
                            
                            
                                ProfileImage(mood: $mood, gender: $gender, selectedMood: $selectedMood, selectedType: $selectedType, randomSeed: $randomSeed)
                            
                            Form {
                                
                                Section {
                                    Picker(selection: $selectedMood, label: CustomText(text: "Mood", size: 18, color: purpleColor)) {
                                        ForEach(0 ..< self.mood.count) { index in
                                            CustomText(text: self.mood[index], size: 16, color: .black)
                                        }
                                    }
                                }.listRowBackground(Color.clear)
                                
                                Section {
                                    Picker(selection: $selectedType, label: CustomText(text: "Type", size: 18, color: purpleColor)) {
                                        ForEach(0 ..< self.gender.count) { index in
                                            CustomText(text: self.gender[index], size: 16, color: .black)
                                        }
                                    }
                                }
                                
                                Section {
                                    Button(action:setRandomSeed) {
                                        HStack{
                                            Spacer()
                                            CustomText(text: "Randomize", size: 16, color: .black).multilineTextAlignment(.center)
                                            Spacer()
                                        }
                                        
                                    }.multilineTextAlignment(.center)
                                }
                            }
                            Spacer()
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white).frame(width: 345, height: 50, alignment: .center)
                                CustomText(text: "Save", size: 18, color: purpleColor)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 345, height: 50)
                                .background(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 3))
                            }.onTapGesture(perform: saveImage)
                            
                        }
                    }.background(Color.clear)
                }
            }
        }
    }
}
