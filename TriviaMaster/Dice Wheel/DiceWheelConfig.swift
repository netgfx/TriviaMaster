//
//  DiceWheelConfig.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 10/1/21.
//
//


import Foundation
import UIKit
import SwiftFortuneWheel
import SwiftUI

private let circleStrokeWidth: CGFloat = 2
private let blueDiceColor = UIColor(red: 51/255, green: 170/255, blue: 255/255, alpha: 1.0)
private let orangeDiceColor = UIColor(red: 220/255, green: 60/255, blue: 96/255, alpha: 1.0)

public extension SFWConfiguration {
    static var DiceWheelConfiguration: SFWConfiguration {
        
        let _position: SFWConfiguration.Position = .top
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                   strokeColor: .black)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: blueDiceColor, oddColor: orangeDiceColor)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: .black)
        
        let wheeelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences,
                                                                          startPosition: _position)
                
        let configuration = SFWConfiguration(wheelPreferences: wheeelPreferences)

        return configuration
    }
}

public extension TextPreferences {
    static var diceTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont(name: "KGBlankSpaceSolid", size: 16.0)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font!,
                                          verticalOffset: 10)
        return prefenreces
    }

    static var diceDescriptionTextPreferences: TextPreferences {
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

