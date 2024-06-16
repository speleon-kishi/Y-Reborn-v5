#import "VideoOptionsController.h"

#define BOOL_FOR_KEY(KEY) [[NSUserDefaults standardUserDefaults] boolForKey:KEY]
#define SET_BOOL_FOR_KEY(KEY, VALUE) [[NSUserDefaults standardUserDefaults] setBool:VALUE forKey:KEY]; [[NSUserDefaults standardUserDefaults] synchronize];

#define TOGGLE_SETTING(KEY, SENDER) \
if ([SENDER isOn]) { \
    SET_BOOL_FOR_KEY(KEY, YES); \
} else { \
    SET_BOOL_FOR_KEY(KEY, NO); \
}

#define CREATE_SWITCH(NAME, SELECTOR, KEY) \
UISwitch *NAME = [[UISwitch alloc] initWithFrame:CGRectZero]; \
[NAME addTarget:self action:@selector(SELECTOR:) forControlEvents:UIControlEventValueChanged]; \
NAME.on = BOOL_FOR_KEY(KEY);\
cell.accessoryView = NAME;

@interface VideoOptionsController ()
- (void)coloursView;
@end

@implementation VideoOptionsController

- (void)loadView {
	[super loadView];
    [self coloursView];

    self.title = @"Video Options";

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneButton;

    [self.tableView setSectionHeaderTopPadding:0.0f];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kEnableCustomDoubleTapToSkipDuration"] == YES) {
        return 14;
    }
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoTableViewCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }
        else {
            cell.backgroundColor = [UIColor colorWithRed:0.110 green:0.110 blue:0.118 alpha:1.0];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Enable No Ads";
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kRebornIHaveYouTubePremium"] == YES) {
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
            } else {
                CREATE_SWITCH(enableNoVideoAds, toggleEnableNoVideoAds, @"kEnableNoVideoAds");
            }
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"Enable Background Playback";
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kRebornIHaveYouTubePremium"] == YES) {
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
            } else {
                CREATE_SWITCH(enableBackgroundPlayback, toggleEnableBackgroundPlayback, @"kEnableBackgroundPlayback");
            }
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"Allow HD On Cellular Data";
            CREATE_SWITCH(allowHDOnCellularData, toggleAllowHDOnCellularData, @"kAllowHDOnCellularData");
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"Auto Play In FullScreen";
            CREATE_SWITCH(autoFullScreen, toggleAutoFullScreen, @"kAutoFullScreen");
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = @"Disable Video Endscreen Popups";
            CREATE_SWITCH(disableVideoEndscreenPopups, toggleDisableVideoEndscreenPopups, @"kDisableVideoEndscreenPopups");
        }
        if (indexPath.row == 5) {
            cell.textLabel.text = @"Disable Video Info Cards";
            CREATE_SWITCH(disableVideoInfoCards, toggleDisableVideoInfoCards, @"kDisableVideoInfoCards");
        }
        if (indexPath.row == 6) {
            cell.textLabel.text = @"Disable Video AutoPlay";
            CREATE_SWITCH(disableVideoAutoPlay, toggleDisableVideoAutoPlay, @"kDisableVideoAutoPlay");
        }
        if (indexPath.row == 7) {
            cell.textLabel.text = @"Hide Channel Watermark";
            CREATE_SWITCH(hideChannelWatermark, toggleHideChannelWatermark, @"kHideChannelWatermark");
        }
        if (indexPath.row == 8) {
            cell.textLabel.text = @"Hide Player Bar Heatwave";
            CREATE_SWITCH(hidePlayerBarHeatwave, toggleHidePlayerBarHeatwave, @"kHidePlayerBarHeatwave");
        }
        if (indexPath.row == 9) {
            cell.textLabel.text = @"Always Show Player Bar";
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kDisableRelatedVideosInOverlay"] == NO || [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideOverlayQuickActions"] == NO) {
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
            } else {
                CREATE_SWITCH(alwaysShowPlayerBar, toggleAlwaysShowPlayerBar, @"kAlwaysShowPlayerBarVTwo");
            }
        }
        if (indexPath.row == 10) {
            cell.textLabel.text = @"Enable Extra Speed Options";
            CREATE_SWITCH(enableExtraSpeedOptions, toggleExtraSpeedOptions, @"kEnableExtraSpeedOptions");
        }
        if (indexPath.row == 11) {
            cell.textLabel.text = @"Disable Double Tap To Skip";
            CREATE_SWITCH(disableDoubleTapToSkip, toggleDisableDoubleTapToSkip, @"kDisableDoubleTapToSkip");
        }
        if (indexPath.row == 12) {
            cell.textLabel.text = @"Enable Custom Double Tap To Skip Duration";
            CREATE_SWITCH(enableCustomDoubleTapToSkipDuration, toggleEnableCustomDoubleTapToSkipDuration, @"kEnableCustomDoubleTapToSkipDuration");
        }
        if (indexPath.row == 13) {
            UIStepper *customDoubleTapToSkipDurationStepper = [[UIStepper alloc] initWithFrame:CGRectZero];
            customDoubleTapToSkipDurationStepper.stepValue = 1;
            customDoubleTapToSkipDurationStepper.minimumValue = 1;
            customDoubleTapToSkipDurationStepper.maximumValue = 1000;
            if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"kCustomDoubleTapToSkipDuration"]) {
                customDoubleTapToSkipDurationStepper.value = [[NSUserDefaults standardUserDefaults] doubleForKey:@"kCustomDoubleTapToSkipDuration"];
                cell.textLabel.text = [NSString stringWithFormat:@"Value (Seconds): %.lf", [[NSUserDefaults standardUserDefaults] doubleForKey:@"kCustomDoubleTapToSkipDuration"]];
            } else {
                customDoubleTapToSkipDurationStepper.value = 10;
                cell.textLabel.text = @"Value (Seconds): 10";
            }
            [customDoubleTapToSkipDurationStepper addTarget:self action:@selector(customDoubleTapToSkipDurationStepperValueChanged:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = customDoubleTapToSkipDurationStepper;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        UIAlertController *alertError = [UIAlertController alertControllerWithTitle:@"Notice" message:@"This feature has been disabled cause you have the 'I Have YouTube Premium' option enabled" preferredStyle:UIAlertControllerStyleAlert];

        [alertError addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];

        [self presentViewController:alertError animated:YES completion:nil];
    }
    if (indexPath.row == 10) {
        UIAlertController *alertError = [UIAlertController alertControllerWithTitle:@"Notice" message:@"You must enable 'Disable Related Videos In Overlay' and 'Hide Overlay Quick Actions' in YouTube Reborn settings to use 'Always Show Player Bar'" preferredStyle:UIAlertControllerStyleAlert];

        [alertError addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];

        [self presentViewController:alertError animated:YES completion:nil];
    }
}

- (void)coloursView {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
        self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.969 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }
    else {
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self coloursView];
    [self.tableView reloadData];
}

@end

@implementation VideoOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleEnableNoVideoAds:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnableNoVideoAds", sender);
}

- (void)toggleEnableBackgroundPlayback:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnableBackgroundPlayback", sender);
}

- (void)toggleEnablePictureInPicture:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnablePictureInPicture", sender);
}

- (void)toggleAllowHDOnCellularData:(UISwitch *)sender {
    TOGGLE_SETTING(@"kAllowHDOnCellularData", sender);
}

- (void)toggleAutoFullScreen:(UISwitch *)sender {
    TOGGLE_SETTING(@"kAutoFullScreen", sender);
}

- (void)toggleDisableVideoEndscreenPopups:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableVideoEndscreenPopups", sender);
}

- (void)toggleDisableVideoInfoCards:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableVideoInfoCards", sender);
}

- (void)toggleDisableVideoAutoPlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableVideoAutoPlay", sender);
}

- (void)toggleHideChannelWatermark:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideChannelWatermark", sender);
}

- (void)toggleHidePlayerBarHeatwave:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHidePlayerBarHeatwave", sender);
}

- (void)toggleAlwaysShowPlayerBar:(UISwitch *)sender {
    TOGGLE_SETTING(@"kAlwaysShowPlayerBarVTwo", sender);
}

- (void)toggleExtraSpeedOptions:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnableExtraSpeedOptions", sender);
}

- (void)toggleDisableDoubleTapToSkip:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableDoubleTapToSkip", sender);
}

- (void)toggleEnableCustomDoubleTapToSkipDuration:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnableCustomDoubleTapToSkipDuration", sender);
    [self.tableView reloadData];
}

- (void)customDoubleTapToSkipDurationStepperValueChanged:(UIStepper *)sender {
    [[NSUserDefaults standardUserDefaults] setDouble:sender.value forKey:@"kCustomDoubleTapToSkipDuration"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

@end
