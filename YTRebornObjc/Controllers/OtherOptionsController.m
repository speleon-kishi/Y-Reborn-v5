#import "OtherOptionsController.h"

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

@interface OtherOptionsController ()
- (void)coloursView;
@end

@implementation OtherOptionsController

- (void)loadView {
    [super loadView];
    [self coloursView];

    self.title = @"Other Options";

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneButton;

    [self.tableView setSectionHeaderTopPadding:0.0f];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherTableViewCell"];

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
            cell.textLabel.text = @"Enable iPad Style On iPhone";
            CREATE_SWITCH(enableiPadStyleOniPhone, toggleEnableiPadStyleOniPhone, @"kEnableiPadStyleOniPhone");
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"No Cast Button";
            CREATE_SWITCH(noCastButton, toggleNoCastButton, @"kNoCastButton");
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"No Notification Button";
            CREATE_SWITCH(noNotificationButton, toggleNoNotificationButton, @"kNoNotificationButton");
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"No Search Button";
            CREATE_SWITCH(noSearchButton, toggleNoSearchButton, @"kNoSearchButton");
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = @"Disable YouTube Kids";
            CREATE_SWITCH(disableYouTubeKidsPopup, toggleDisableYouTubeKidsPopup, @"kDisableYouTubeKidsPopup");
        }
        if (indexPath.row == 5) {
            cell.textLabel.text = @"Disable Hints";
            CREATE_SWITCH(disableHints, toggleDisableHints, @"kDisableHints");
        }
        if (indexPath.row == 6) {
            cell.textLabel.text = @"Hide YouTube Logo";
            CREATE_SWITCH(hideYouTubeLogo, toggleHideYouTubeLogo, @"kHideYouTubeLogo");
        }
    }
    return cell;
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

@implementation OtherOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleEnableiPadStyleOniPhone:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnableiPadStyleOniPhone", sender);
}

- (void)toggleNoCastButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kNoCastButton", sender);
}

- (void)toggleNoNotificationButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kNoNotificationButton", sender);
}

- (void)toggleNoSearchButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kNoSearchButton", sender);
}

- (void)toggleDisableYouTubeKidsPopup:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableYouTubeKidsPopup", sender);
}

- (void)toggleDisableHints:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableHints", sender);
}

- (void)toggleHideYouTubeLogo:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideYouTubeLogo", sender);
}

@end
