//
//  WheelConfig.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 19/12/20.
//

import Foundation
import UIKit
import SwiftFortuneWheel
import SwiftUI

private let circleStrokeWidth: CGFloat = 2
private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let redColor = UIColor.red
var colors:Array<SFWColor> = [SFWColor(greenColor), SFWColor(pinkColor), SFWColor(purpleColor), SFWColor(goldColor), SFWColor(lightGreenColor), SFWColor(orangeColor), SFWColor(palePink), SFWColor(lightPurple), SFWColor(greenBlueColor)]

public extension SFWConfiguration {
    static var WheelConfiguration: SFWConfiguration {
        
        let _position: SFWConfiguration.Position = .top
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.customPatternColors(colors: colors, defaultColor: .white) //.evenOddColors(evenColor: blackColor, oddColor: redColor)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        
        let wheeelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences,
                                                                          startPosition: _position)
                
        let configuration = SFWConfiguration(wheelPreferences: wheeelPreferences)

        return configuration
    }
}

public extension TextPreferences {
    static var withoutStoryboardExampleAmountTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont(name: "KGBlankSpaceSolid", size: 16.0)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font!,
                                          verticalOffset: 10)
        return prefenreces
    }

    static var withoutStoryboardExampleDescriptionTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont(name: "KGBlankSpaceSolid", size: 16.0)
        var prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font!,
                                          verticalOffset: 0)
        
        prefenreces.orientation = .vertical
        prefenreces.flipUpsideDown = false
        prefenreces.isCurved = false
        
        return prefenreces
    }
}

public extension ImagePreferences {
    static var prizeImagePreferences: ImagePreferences {
        let preferences = ImagePreferences(preferredSize: CGSize(width: 28, height: 28),
                                           verticalOffset: 0)
        return preferences
    }
}
