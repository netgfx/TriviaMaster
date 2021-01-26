//
//  SVGView.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 22/12/20.
//

import Foundation
import SwiftUI
import Macaw
import UIKit

class MacawTextView: MacawView {
    @Binding var mainStr:String
    let str = String("<svg width='264px' height='280px' viewBox='0 0 264 280' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' data-reactroot=''><desc>Created with getavataaars.com</desc><defs><circle id='path-1' cx='120' cy='120' r='120'></circle><path d='M12,160 C12,226.27417 65.72583,280 132,280 C198.27417,280 252,226.27417 252,160 L264,160 L264,-1.42108547e-14 L-3.19744231e-14,-1.42108547e-14 L-3.19744231e-14,160 L12,160 Z' id='path-3'></path><path d='M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z' id='path-5'></path></defs><g id='Avataaar' stroke='none' stroke-width='1' fill='none' fill-rule='evenodd'><g transform='translate(-825.000000, -1100.000000)' id='Avataaar/Circle'><g transform='translate(825.000000, 1100.000000)'><g id='Circle' stroke-width='1' fill-rule='evenodd' transform='translate(12.000000, 40.000000)'><mask id='mask-2' fill='white'><use xlink:href='#path-1'></use></mask><use id='Circle-Background' fill='#E6E6E6' xlink:href='#path-1'></use><g id='Color/Palette/Blue-01' mask='url(#mask-2)' fill='#65C9FF'><rect id='🖍Color' x='0' y='0' width='240' height='240'></rect></g></g><mask id='mask-4' fill='white'><use xlink:href='#path-3'></use></mask><g id='Mask'></g><g id='Avataaar' stroke-width='1' fill-rule='evenodd' mask='url(#mask-4)'><g id='Body' transform='translate(32.000000, 36.000000)'><mask id='mask-6' fill='white'><use xlink:href='#path-5'></use></mask><use fill='#D0C6AC' xlink:href='#path-5'></use><g id='Skin/👶🏽-03-Brown' mask='url(#mask-6)' fill='#FD9841'><g transform='translate(0.000000, 0.000000)' id='Color'><rect x='0' y='0' width='264' height='280'></rect></g></g><path d='M156,79 L156,102 C156,132.927946 130.927946,158 100,158 C69.072054,158 44,132.927946 44,102 L44,79 L44,94 C44,124.927946 69.072054,150 100,150 C130.927946,150 156,124.927946 156,94 L156,79 Z' id='Neck-Shadow' fill-opacity='0.100000001' fill='#000000' mask='url(#mask-6)'></path></g><g id='Clothing/Blazer-+-Shirt' transform='translate(0.000000, 170.000000)'><defs><path d='M133.960472,0.294916112 C170.936473,3.32499816 200,34.2942856 200,72.0517235 L200,81 L0,81 L0,72.0517235 C1.22536245e-14,33.9525631 29.591985,2.76498122 67.0454063,0.219526408 C67.0152598,0.593114549 67,0.969227185 67,1.34762511 C67,13.2107177 81.9984609,22.8276544 100.5,22.8276544 C119.001539,22.8276544 134,13.2107177 134,1.34762511 C134,0.994669088 133.986723,0.64370138 133.960472,0.294916112 Z' id='react-path-352953'></path></defs><g id='Shirt' transform='translate(32.000000, 29.000000)'><mask id='react-mask-352954' fill='white'><use xlink:href='#react-path-352953'></use></mask><use id='Clothes' fill='#E6E6E6' xlink:href='#react-path-352953'></use><g id='Color/Palette/Black' mask='url(#react-mask-352954)' fill='#262E33'><g transform='translate(-32.000000, -29.000000)' id='🖍Color'><rect x='0' y='0' width='264' height='110'></rect></g></g><g id='Shadowy' opacity='0.599999964' mask='url(#react-mask-352954)' fill-opacity='0.16' fill='#000000'><g transform='translate(60.000000, -25.000000)' id='Hola-👋🏼'><ellipse cx='40.5' cy='27.8476251' rx='39.6351047' ry='26.9138272'></ellipse></g></g></g><g id='Blazer' transform='translate(32.000000, 28.000000)'><path d='M68.784807,1.12222847 C30.512317,2.80409739 -1.89486556e-14,34.3646437 -1.42108547e-14,73.0517235 L0,73.0517235 L0,82 L69.3616767,82 C65.9607412,69.9199941 64,55.7087296 64,40.5 C64,26.1729736 65.7399891,12.7311115 68.784807,1.12222847 Z M131.638323,82 L200,82 L200,73.0517235 C200,34.7067641 170.024954,3.36285166 132.228719,1.17384225 C135.265163,12.7709464 137,26.1942016 137,40.5 C137,55.7087296 135.039259,69.9199941 131.638323,82 Z' id='Saco' fill='#3A4C5A'></path><path d='M149,58 L158.555853,50.83311 L158.555853,50.83311 C159.998897,49.7508275 161.987779,49.7682725 163.411616,50.8757011 L170,56 L149,58 Z' id='Pocket-hanky' fill='#E6E6E6'></path><path d='M69,1.13686838e-13 C65,19.3333333 66.6666667,46.6666667 74,82 L58,82 L44,46 L50,37 L44,31 L63,1 C65.027659,0.369238637 67.027659,0.0359053037 69,1.13686838e-13 Z' id='Wing' fill='#2F4351'></path><path d='M151,1.13686838e-13 C147,19.3333333 148.666667,46.6666667 156,82 L140,82 L126,46 L132,37 L126,31 L145,1 C147.027659,0.369238637 149.027659,0.0359053037 151,1.13686838e-13 Z' id='Wing' fill='#2F4351' transform='translate(141.000000, 41.000000) scale(-1, 1) translate(-141.000000, -41.000000) '></path></g></g><g id='Face' transform='translate(76.000000, 82.000000)' fill='#000000'><g id='Mouth/Concerned' transform='translate(2.000000, 52.000000)'><defs><path d='M35.117844,15.1280772 C36.1757121,24.6198025 44.2259873,32 54,32 C63.8042055,32 71.8740075,24.574136 72.8917593,15.0400546 C72.9736685,14.272746 72.1167429,13 71.042767,13 C56.1487536,13 44.7379213,13 37.0868244,13 C36.0066168,13 35.0120058,14.1784435 35.117844,15.1280772 Z' id='react-path-352955'></path></defs><mask id='react-mask-352956' fill='white'><use xlink:href='#react-path-352955' transform='translate(54.003637, 22.500000) scale(1, -1) translate(-54.003637, -22.500000) '></use></mask><use id='Mouth' fill-opacity='0.699999988' fill='#000000' fill-rule='evenodd' transform='translate(54.003637, 22.500000) scale(1, -1) translate(-54.003637, -22.500000) ' xlink:href='#react-path-352955'></use><rect id='Teeth' fill='#FFFFFF' fill-rule='evenodd' mask='url(#react-mask-352956)' x='39' y='2' width='31' height='16' rx='5'></rect><g id='Tongue' stroke-width='1' fill-rule='evenodd' mask='url(#react-mask-352956)' fill='#FF4F6D'><g transform='translate(38.000000, 24.000000)'><circle id='friend?' cx='11' cy='11' r='11'></circle><circle id='How-you-doing' cx='21' cy='11' r='11'></circle></g></g></g><g id='Nose/Default' transform='translate(28.000000, 40.000000)' fill-opacity='0.16'><path d='M16,8 C16,12.418278 21.372583,16 28,16 L28,16 C34.627417,16 40,12.418278 40,8' id='Nose'></path></g><g id='Eyes/Closed-😌' transform='translate(0.000000, 8.000000)' fill-opacity='0.599999964'><path d='M16.1601674,32.4473116 C18.006676,28.648508 22.1644225,26 26.9975803,26 C31.8136766,26 35.9591217,28.629842 37.8153518,32.4071242 C38.3667605,33.5291977 37.5821037,34.4474817 36.790607,33.7670228 C34.3395063,31.6597833 30.8587163,30.3437884 26.9975803,30.3437884 C23.2572061,30.3437884 19.8737584,31.5787519 17.4375392,33.5716412 C16.5467928,34.3002944 15.6201012,33.5583844 16.1601674,32.4473116 Z' id='Closed-Eye' transform='translate(27.000000, 30.000000) scale(1, -1) translate(-27.000000, -30.000000) '></path><path d='M74.1601674,32.4473116 C76.006676,28.648508 80.1644225,26 84.9975803,26 C89.8136766,26 93.9591217,28.629842 95.8153518,32.4071242 C96.3667605,33.5291977 95.5821037,34.4474817 94.790607,33.7670228 C92.3395063,31.6597833 88.8587163,30.3437884 84.9975803,30.3437884 C81.2572061,30.3437884 77.8737584,31.5787519 75.4375392,33.5716412 C74.5467928,34.3002944 73.6201012,33.5583844 74.1601674,32.4473116 Z' id='Closed-Eye' transform='translate(85.000000, 30.000000) scale(1, -1) translate(-85.000000, -30.000000) '></path></g><g id='Eyebrow/Outline/Angry' fill-opacity='0.599999964' fill-rule='nonzero'><path d='M15.6114904,15.1845247 C19.8515017,9.41618792 22.4892046,9.70087612 28.9238518,14.5564693 C29.1057771,14.6937504 29.2212592,14.7812575 29.5936891,15.063789 C34.4216439,18.7263562 36.7081807,20 40,20 C41.1045695,20 42,19.1045695 42,18 C42,16.8954305 41.1045695,16 40,16 C37.9337712,16 36.0986396,14.9777974 32.011227,11.8770179 C31.6358269,11.5922331 31.5189458,11.5036659 31.3332441,11.3635351 C27.5737397,8.52660822 25.3739873,7.28738405 22.6379899,6.99208688 C18.9538127,6.59445233 15.5799484,8.47367246 12.3885096,12.8154753 C11.7343147,13.7054768 11.9254737,14.9572954 12.8154753,15.6114904 C13.7054768,16.2656853 14.9572954,16.0745263 15.6114904,15.1845247 Z' id='Eyebrow'></path><path d='M73.6114904,15.1845247 C77.8515017,9.41618792 80.4892046,9.70087612 86.9238518,14.5564693 C87.1057771,14.6937504 87.2212592,14.7812575 87.5936891,15.063789 C92.4216439,18.7263562 94.7081807,20 98,20 C99.1045695,20 100,19.1045695 100,18 C100,16.8954305 99.1045695,16 98,16 C95.9337712,16 94.0986396,14.9777974 90.011227,11.8770179 C89.6358269,11.5922331 89.5189458,11.5036659 89.3332441,11.3635351 C85.5737397,8.52660822 83.3739873,7.28738405 80.6379899,6.99208688 C76.9538127,6.59445233 73.5799484,8.47367246 70.3885096,12.8154753 C69.7343147,13.7054768 69.9254737,14.9572954 70.8154753,15.6114904 C71.7054768,16.2656853 72.9572954,16.0745263 73.6114904,15.1845247 Z' id='Eyebrow' transform='translate(84.999934, 13.470064) scale(-1, 1) translate(-84.999934, -13.470064) '></path></g></g><g id='Top' stroke-width='1' fill-rule='evenodd'><defs><rect id='react-path-352959' x='0' y='0' width='264' height='280'></rect><filter x='-0.8%' y='-2.0%' width='101.5%' height='108.0%' filterUnits='objectBoundingBox' id='react-filter-352957'><feOffset dx='0' dy='2' in='SourceAlpha' result='shadowOffsetOuter1'></feOffset><feColorMatrix values='0 0 0 0 0   0 0 0 0 0   0 0 0 0 0  0 0 0 0.16 0' type='matrix' in='shadowOffsetOuter1' result='shadowMatrixOuter1'></feColorMatrix><feMerge><feMergeNode in='shadowMatrixOuter1'></feMergeNode><feMergeNode in='SourceGraphic'></feMergeNode></feMerge></filter></defs><mask id='react-mask-352958' fill='white'><use xlink:href='#react-path-352959'></use></mask><g id='Mask'></g><g id='Top/No-Hair' mask='url(#react-mask-352958)'><g transform='translate(-1.000000, 0.000000)'></g></g></g></g></g></g></g></svg>")
    
    required init?(localMainStr: Binding<String>, coder aDecoder: NSCoder) {
        
        self._mainStr = localMainStr
        super.init(frame: CGRect.zero)
        //let parsed = try! String(contentsOfFile: str, encoding: String.Encoding.utf8)
        var parsedStr = try! SVGParser.parse(text: "")
        do {
            parsedStr = try SVGParser.parse(text: mainStr)
        }
        catch{
            print("error parsing")
        }
        //let text = Text(text: parsed, place: .move(dx: 145, dy: 100))
        
        node = parsedStr
    }
    
    init(localMainStr: Binding<String>) {
        let rect  = CGRect(x: 0, y: 0, width: 96, height: 96)
        
        self._mainStr = localMainStr
        super.init(frame: rect)
        var parsedStr = try! SVGParser.parse(text: "")
        //let parsed = try! String( String(contentsOfFile: str, encoding: String.Encoding.utf8)
        do {
            parsedStr = try SVGParser.parse(text: mainStr)
        }
        catch{
            print("error parsing")
        }
        //let text = Text(text: parsedStr, place: .move(dx: 145, dy: 100))
        
        node = parsedStr
    }
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func convertToNativeImage() -> UIImage {
        return node.toNativeImage(size: Size(96, 96))
    }
}

struct SVGUIView: UIViewRepresentable {
    @Binding var mainStr:String
    func makeUIView(context: Context) -> UIImageView {
        let img:UIImage = MacawTextView(localMainStr: $mainStr).convertToNativeImage()
        let uiImg = UIImageView(image: img)
        uiImg.clipsToBounds = true
        
        return uiImg
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        let img:UIImage = MacawTextView(localMainStr: $mainStr).convertToNativeImage()
        
        uiView.image = img
    }
}
