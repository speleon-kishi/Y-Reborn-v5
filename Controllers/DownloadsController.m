#import "DownloadsController.h"
#import "DownloadsVideoController.h"
#import "DownloadsAudioController.h"

@interface DownloadsController ()
- (void)configureUI;
- (void)doneButtonTapped;
@end

@implementation DownloadsController

- (void)loadView {
    [super loadView];
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
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    DownloadsVideoController *videoViewController = [[DownloadsVideoController alloc] init];
    videoViewController.title = @"Video";
    videoViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Video" image:[UIImage systemImageNamed:@"video.circle.fill"] tag:0];
    UINavigationController *videoNavViewController = [[UINavigationController alloc] initWithRootViewController:videoViewController];
    
    DownloadsAudioController *audioViewController = [[DownloadsAudioController alloc] init];
    audioViewController.title = @"Audio";
    audioViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Audio" image:[UIImage systemImageNamed:@"music.note"] tag:1];
    UINavigationController *audioNavViewController = [[UINavigationController alloc] initWithRootViewController:audioViewController];
    
    if (@available(iOS 18, *)) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self setupNewTabBarWithControllers:@[videoNavViewController, audioNavViewController]];
        } else {
            [self setupOldTabBarWithControllers:@[videoNavViewController, audioNavViewController]];
        }
    } else {
        [self setupOldTabBarWithControllers:@[videoNavViewController, audioNavViewController]];
    }
}

- (void)setupNewTabBarWithControllers:(NSArray *)viewControllers {
    self.tabBar = [[UITabBarController alloc] init];
    self.tabBar.viewControllers = viewControllers;
    self.tabBar.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.tabBar.tintColor = [UIColor systemBlueColor];
    
    if (@available(iOS 18, *)) {
        UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
        tabBarAppearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
        tabBarAppearance.backgroundColor = [UIColor systemBackgroundColor];
        self.tabBar.tabBar.standardAppearance = tabBarAppearance;
        self.tabBar.tabBar.scrollEdgeAppearance = tabBarAppearance;
        
        self.tabBar.tabBar.layer.cornerRadius = 10;
        self.tabBar.tabBar.layer.masksToBounds = YES;
        self.tabBar.tabBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.tabBar.tabBar.layer.borderWidth = 0.5;
        
        self.tabBar.tabBar.translatesAutoresizingMaskIntoConstraints = NO;
        [self.tabBar.tabBar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10].active = YES;
        [self.tabBar.tabBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
        [self.tabBar.tabBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
    }
    
    [self addChildViewController:self.tabBar];
    self.tabBar.view.frame = self.view.bounds;
    [self.view addSubview:self.tabBar.view];
    [self.tabBar didMoveToParentViewController:self];
}

- (void)setupOldTabBarWithControllers:(NSArray *)viewControllers {
    self.tabBar = [[UITabBarController alloc] init];
    self.tabBar.viewControllers = viewControllers;
    self.tabBar.tabBar.barStyle = UIBarStyleBlack;
    self.tabBar.tabBar.tintColor = [UIColor darkGrayColor];
    
    [self addChildViewController:self.tabBar];
    self.tabBar.view.frame = self.view.bounds;
    [self.view addSubview:self.tabBar.view];
    [self.tabBar didMoveToParentViewController:self];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self configureUI];
}

- (void)doneButtonTapped {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
