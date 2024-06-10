import Orion
import YouTubeRebornC

// Video Options

// Disable Double Tap To Skip

struct DisableDoubleTapToSkip: HookGroup {}

class DisableDoubleTapToSkip1: ClassHook<YTDoubleTapToSeekController> {
    typealias Group = DisableDoubleTapToSkip
    func enableDoubleTapToSeek(_ arg1: Bool) {
        orig.enableDoubleTapToSeek(false)
    }
    func showDoubleTapToSeekEducationView(_ arg1: Bool) {
        orig.showDoubleTapToSeekEducationView(false)
    }
}

class DisableDoubleTapToSkip2: ClassHook<YTSettings> {
    typealias Group = DisableDoubleTapToSkip
    func doubleTapToSeekEnabled() -> Bool {
        return false
    }
}

// Overlay Options

// Hide Dark Background

struct HideDarkBackground: HookGroup {}

class HideDarkBackground1: ClassHook<YTMainAppVideoPlayerOverlayView> {
    typealias Group = HideDarkBackground
    func setBackgroundVisible(_ arg1: Bool, isGradientBackground arg2: Bool) {
        orig.setBackgroundVisible(false, isGradientBackground: arg2)
    }
}

// Other Options

// Disable YouTube Kids

struct DisableYouTubeKids: HookGroup {}

class DisableYouTubeKids1: ClassHook<YTWatchMetadataAppPromoCell> {
    typealias Group = DisableYouTubeKids
    func initWithFrame(_ arg1: CGRect) -> Any? {
        return nil
    }
}

class DisableYouTubeKids2: ClassHook<YTHUDMessageView> {
    typealias Group = DisableYouTubeKids
    func initWithMessage(_ arg1: Any?, dismissHandler arg2: Any?) -> Any? {
        return nil
    }
}

class DisableYouTubeKids4: ClassHook<YTWatchMiniBarViewController> {
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
        
        // DisableDoubleTapToSkip().activate()

        // Overlay Options

        // HideDarkBackground().activate()

        // Other Options

        // DisableYouTubeKids().activate()
    }
}