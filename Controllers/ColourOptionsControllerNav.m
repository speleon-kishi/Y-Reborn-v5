#import "ColourOptionsControllerNav.h"
#import "ColourOptionsController.h"
#import "ColourOptionsController2.h"
#import "ColourOptionsController3.h"
#import "ColourOptionsController4.h"
#import "Localization.h"

@interface ColourOptionsControllerNav ()
- (void)configureUI;
- (void)doneButtonTapped;
@end

@implementation ColourOptionsControllerNav

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)configureUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    UINavigationBarAppearance *navigationBarAppearance = [[UINavigationBarAppearance alloc] init];
    navigationBarAppearance.backgroundColor = [UIColor systemBackgroundColor];
    navigationBarAppearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];

    [self.navigationController.navigationBar setStandardAppearance:navigationBarAppearance];
    [self.navigationController.navigationBar setScrollEdgeAppearance:navigationBarAppearance];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor labelColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;

    ColourOptionsController *colorViewController = [[ColourOptionsController alloc] init];
    colorViewController.title = LOC(@"CUSTOM_THEME_TAB");
    colorViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOC(@"CUSTOM_THEME_TAB") image:[UIImage systemImageNamed:@"paintpalette.fill"] tag:0];
    UINavigationController *colorNavViewController = [[UINavigationController alloc] initWithRootViewController:colorViewController];

    ColourOptionsController2 *colorViewController2 = [[ColourOptionsController2 alloc] init];
    colorViewController2.title = LOC(@"CUSTOM_TINT_TAB");
    colorViewController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOC(@"CUSTOM_TINT_TAB") image:[UIImage systemImageNamed:@"drop.fill"] tag:1];
    UINavigationController *colorNavViewController2 = [[UINavigationController alloc] initWithRootViewController:colorViewController2];

    ColourOptionsController3 *colorViewController3 = [[ColourOptionsController3 alloc] init];
    colorViewController3.title = LOC(@"CUSTOM_SYSTEMBLUE_TAB");
    colorViewController3.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOC(@"CUSTOM_SYSTEMBLUE_TAB") image:[UIImage systemImageNamed:@"square.stack"] tag:2];
    UINavigationController *colorNavViewController3 = [[UINavigationController alloc] initWithRootViewController:colorViewController3];

    ColourOptionsController4 *colorViewController4 = [[ColourOptionsController4 alloc] init];
    colorViewController4.title = LOC(@"CUSTOM_PROGRESS_BAR_TAB");
    colorViewController4.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOC(@"CUSTOM_PROGRESS_BAR_TAB") image:[UIImage systemImageNamed:@"waveform.path.ecg"] tag:3];
    UINavigationController *colorNavViewController4 = [[UINavigationController alloc] initWithRootViewController:colorViewController4];

    if (@available(iOS 18, *)) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self setupNewTabBar];
        } else {
            [self setupOldTabBar];
        }
    } else {
        [self setupOldTabBar];
    }
    
    [self addChildViewController:self.tabBarController];
    self.tabBarController.view.frame = self.view.bounds;
    [self.view addSubview:self.tabBarController.view];
    [self.tabBarController didMoveToParentViewController:self];
}

- (void)setupNewTabBar {
    UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
    tabBarAppearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
    tabBarAppearance.backgroundColor = [UIColor systemBackgroundColor];
    self.tabBarController.tabBar.standardAppearance = tabBarAppearance;
    self.tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance;

    self.tabBarController.tabBar.layer.cornerRadius = 10;
    self.tabBarController.tabBar.layer.masksToBounds = YES;
    self.tabBarController.tabBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tabBarController.tabBar.layer.borderWidth = 0.5;

    self.tabBarController.tabBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabBarController.tabBar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10].active = YES;
    [self.tabBarController.tabBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
    [self.tabBarController.tabBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
}

- (void)setupOldTabBar {
    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self configureUI];
}

- (void)doneButtonTapped {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
