#import <rootless.h>
#import "Localization.h"

NSBundle *YouTubeRebornBundle() {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:@"YouTubeReborn" ofType:@"bundle"];
        if (tweakBundlePath) {
            bundle = [NSBundle bundleWithPath:tweakBundlePath];
        } else {
            char resolvedPath[PATH_MAX];
            const char *rootPath = libroot_dyn_jbrootpath("/Library/Application Support/YouTubeReborn.bundle", resolvedPath);
            if (rootPath) {
                bundle = [NSBundle bundleWithPath:[NSString stringWithUTF8String:rootPath]];
            } else {
                bundle = [NSBundle bundleWithPath:@"/Library/Application Support/YouTubeReborn.bundle"];
            }
        }
    });
    return bundle;
}
