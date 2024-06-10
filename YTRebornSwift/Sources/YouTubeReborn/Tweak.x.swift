import Foundation
import Orion
import UIKit
import YouTubeRebornC

// Video Options

// Disable Double Tap To Skip

struct DisableDoubleTapToSkip: HookGroup {}

class DisableDoubleTapToSkip1: ClassHook<NSObject> {
    static let targetName = "YTDoubleTapToSeekController"
    typealias Group = DisableDoubleTapToSkip

    func enableDoubleTapToSeek(_ arg1: Bool) {
        orig.enableDoubleTapToSeek(false)
    }
    func showDoubleTapToSeekEducationView(_ arg1: Bool) {
        orig.showDoubleTapToSeekEducationView(false)
    }
}

class DisableDoubleTapToSkip2: ClassHook<NSObject> { // Check Type
    static let targetName = "YTSettings"
    typealias Group = DisableDoubleTapToSkip

    func doubleTapToSeekEnabled() -> Bool {
        return false
    }
}

// Overlay Options

// Hide Dark Background

struct HideDarkBackground: HookGroup {}

class HideDarkBackground1: ClassHook<UIView> {
    static let targetName = "YTMainAppVideoPlayerOverlayView"
    typealias Group = HideDarkBackground
    
    func setBackgroundVisible(_ arg1: Bool, isGradientBackground arg2: Bool) {
        orig.setBackgroundVisible(false, isGradientBackground: arg2)
    }
}

// Colour Options

var rebornColourOptions: UIColor = UIColor.clear
struct ColorOptions: HookGroup {}

class ColorOptionsA1: ClassHook<UIView> {
    static let targetName = "YTAppView"
    typealias Group = ColorOptions

    func setBackgroundColor(_ arg1: UIColor) {
        orig.setBackgroundColor(rebornColourOptions)
    }
}

class ColorOptionsE1: ClassHook<UIView> {
    static let targetName = "YTELMView"
    typealias Group = ColorOptions

    func setBackgroundColor(_ arg1: UIColor) {
        orig.setBackgroundColor(rebornColourOptions)
    }
}

class ColorOptionsN1: ClassHook<UIView> {
    static let targetName = "YTNavigationBar" // Check Type
    typealias Group = ColorOptions

    func setBackgroundColor(_ arg1: UIColor) {
        orig.setBackgroundColor(rebornColourOptions)
    }
    func setBarTintColor(_ arg1: UIColor) {
        orig.setBarTintColor(rebornColourOptions)
    }
}

class ColorOptionsP1: ClassHook<UIView> {
    static let targetName = "YTPageHeaderView" // Check Type
    typealias Group = ColorOptions

    func setBackgroundColor(_ arg1: UIColor) {
        orig.setBackgroundColor(rebornColourOptions)
    }
}

class ColorOptionsP2: ClassHook<UIView> {
    static let targetName = "YTPivotBarView"
    typealias Group = ColorOptions

    func setBackgroundColor(_ arg1: UIColor) {
        orig.setBackgroundColor(rebornColourOptions)
    }
}

// Other Options

// Disable YouTube Kids

struct DisableYouTubeKids: HookGroup {}

class DisableYouTubeKids1: ClassHook<UIView> { // Check Type
    static let targetName = "YTWatchMetadataAppPromoCell"
    typealias Group = DisableYouTubeKids

    func initWithFrame(_ arg1: CGRect) -> Any? {
        return nil
    }
}

class DisableYouTubeKids2: ClassHook<UIView> {
    static let targetName = "YTHUDMessageView"
    typealias Group = DisableYouTubeKids

    func initWithMessage(_ arg1: Any?, dismissHandler arg2: Any?) -> Any? {
        return nil
    }
}

class DisableYouTubeKids4: ClassHook<UIViewController> {
    static let targetName = "YTNGWatchMiniBarViewController"
    typealias Group = DisableYouTubeKids
    
    func miniplayerRenderer() -> Any? {
        return nil
    }
}

class DisableYouTubeKids5: ClassHook<UIViewController> {
    static let targetName = "YTWatchMiniBarViewController"
    typealias Group = DisableYouTubeKids
    
    func miniplayerRenderer() -> Any? {
        return nil
    }
}

// Loader

struct YouTubeReborn: Tweak {
    static func handleError(_ error: OrionHookError) {
    }

    init() {
        // Video Options
        
        if UserDefaults.standard.bool(forKey: "kDisableDoubleTapToSkip") {
            DisableDoubleTapToSkip().activate()
        }

        // Overlay Options

        if UserDefaults.standard.bool(forKey: "kHideOverlayDarkBackground") {
            HideDarkBackground().activate()
        }

        // Colour Options

        let colourData = UserDefaults.standard.object(forKey: "kYTRebornColourOptionsVFour") as? Data
        if colourData != nil {
            let unarchiver = try! NSKeyedUnarchiver.init(forReadingFrom: colourData!)
            unarchiver.requiresSecureCoding = false
            let colourString = unarchiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! UIColor
            rebornColourOptions = colourString
            ColorOptions().activate()
        }

        // Other Options

        if UserDefaults.standard.bool(forKey: "kDisableYouTubeKidsPopup") {
            DisableYouTubeKids().activate()
        }
    }
}