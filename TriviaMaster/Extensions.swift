//
//  Extensions.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 19/12/20.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
}

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }

    init(millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis / 1000))
        self.addTimeInterval(TimeInterval(Double(millis % 1000) / 1000 ))
    }
}

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
}

//extension UINavigationController {
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//
//    let standard = UINavigationBarAppearance()
//    standard.backgroundColor = .clear //When you scroll or you have title (small one)
//
//    let compact = UINavigationBarAppearance()
//    compact.backgroundColor = .clear //compact-height
//
//    let scrollEdge = UINavigationBarAppearance()
//    scrollEdge.backgroundColor = .clear //When you have large title
//
//    navigationBar.standardAppearance = standard
//    navigationBar.compactAppearance = compact
//    navigationBar.scrollEdgeAppearance = scrollEdge
// }
//}

//
//  EasingEquations.swift
//  DrawingGroup
//
//  Created by Lee Brimelow on 6/15/19.
//  Copyright © 2019 Lee Brimelow. All rights reserved.
//

//public extension BasicAnimationTimingCurve {
//    
//    static var easeInCirc: BasicAnimationTimingCurve {
//        return .custom(0.600, 0.040, 0.980, 0.335)
//    }
//    
//    static var easeInExpo: BasicAnimationTimingCurve {
//        return .custom(0.950, 0.050, 0.795, 0.035)
//    }
//    
//    static var easeInQuart: BasicAnimationTimingCurve {
//        return .custom(0.895, 0.030, 0.685, 0.220)
//    }
//    
//    static var easeInQuint: BasicAnimationTimingCurve {
//        return .custom(0.755, 0.050, 0.855, 0.060)
//    }
//    
//    static var easeInOutCirc: BasicAnimationTimingCurve {
//        return .custom(0.785, 0.135, 0.150, 0.860)
//    }
//    
//    static var easeInOutExpo: BasicAnimationTimingCurve {
//        return .custom(1.000, 0.000, 0.000, 1.000)
//    }
//    
//    static var easeInOutQuart: BasicAnimationTimingCurve {
//        return .custom(0.770, 0.000, 0.175, 1.000)
//    }
//    
//    static var easeInOutQuint: BasicAnimationTimingCurve {
//        return .custom(0.860, 0.000, 0.070, 1.000)
//    }
//    
//    static var easeOutCirc: BasicAnimationTimingCurve {
//        return .custom(0.075, 0.820, 0.165, 1.000)
//    }
//    
//    static var easeOutExpo: BasicAnimationTimingCurve {
//        return .custom(0.190, 1.000, 0.220, 1.000)
//    }
//    
//    static var easeOutQuart: BasicAnimationTimingCurve {
//        return .custom(0.165, 0.840, 0.440, 1.000)
//    }
//    
//    static var easeOutQuint: BasicAnimationTimingCurve {
//        return .custom(0.230, 1.000, 0.320, 1.000)
//    }
//    
//}
