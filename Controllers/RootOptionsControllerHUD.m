#import "RootOptionsController.h"

@implementation CustomHUDView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        blurEffectView.frame = self.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:blurEffectView];
        self.messageLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.textColor = [UIColor whiteColor];
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.font = [UIFont boldSystemFontOfSize:16];
        self.messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.messageLabel];
        if (@available(iOS 12.0, *)) {
            [self.traitCollection performAsCurrentTraitCollection:^{
                if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                    blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                    self.messageLabel.textColor = [UIColor blackColor];
                }
            }];
        }
    }
    return self;
}
- (void)showInView:(UIView *)view withMessage:(NSString *)message {
    self.messageLabel.text = message;
    self.alpha = 0.0;
    self.center = view.center;
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
