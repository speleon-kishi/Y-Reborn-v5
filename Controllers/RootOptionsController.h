#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RootOptionsController : UITableViewController

@end

// Custom HUD
@interface CustomHUDView : UIView
@property (nonatomic, strong) UILabel *messageLabel;
- (void)showInView:(UIView *)view withMessage:(NSString *)message;
- (void)dismiss;
@end
