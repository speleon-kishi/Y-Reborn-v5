#import "TabBarOptionsController.h"
#import "StartupPageOptionsController.h"

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

@interface TabBarOptionsController ()
- (void)coloursView;
@end

@implementation TabBarOptionsController

- (void)loadView {
    [super loadView];
    [self coloursView];

    self.title = @"TabBar Options";

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneButton;

    [self.tableView setSectionHeaderTopPadding:0.0f];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TabBarTableViewCell"];

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
        if (indexPath.section == 0) {
            cell.textLabel.text = @"Startup Page";
            if (![[NSUserDefaults standardUserDefaults] integerForKey:@"kStartupPageIntVThree"]) {
                cell.detailTextLabel.text = @"Home";
            } else {
                int selectedTab = [[NSUserDefaults standardUserDefaults] integerForKey:@"kStartupPageIntVThree"];
                if (selectedTab == 0) {
                    cell.detailTextLabel.text = @"Home";
                }
                if (selectedTab == 1) {
                    cell.detailTextLabel.text = @"Shorts";
                }
                if (selectedTab == 2) {
                    cell.detailTextLabel.text = @"Subscriptions";
                }
                if (selectedTab == 3) {
                    cell.detailTextLabel.text = @"You";
                }
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Hide Tab Bar Labels";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideTabBarLabels, toggleHideTabBarLabels, @"kHideTabBarLabels");
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = @"Hide Shorts Tab";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideShortsTab, toggleHideShortsTab, @"kHideShortsTab");
            }
            if (indexPath.row == 2) {
                cell.textLabel.text = @"Hide Create/Upload (+) Tab";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideUploadTab, toggleHideUploadTab, @"kHideUploadTab");
            }
            if (indexPath.row == 3) {
                cell.textLabel.text = @"Hide Subscriptions Tab";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideSubscriptionsTab, toggleHideSubscriptionsTab, @"kHideSubscriptionsTab");
            }
            if (indexPath.row == 4) {
                cell.textLabel.text = @"Hide You Tab";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideYouTab, toggleHideYouTab, @"kHideYouTab");
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [theTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            StartupPageOptionsController *startupPageOptionsController = [[StartupPageOptionsController alloc] initWithStyle:UITableViewStyleGrouped];
            UINavigationController *startupPageOptionsControllerView = [[UINavigationController alloc] initWithRootViewController:startupPageOptionsController];
            startupPageOptionsControllerView.modalPresentationStyle = UIModalPresentationFullScreen;

            [self presentViewController:startupPageOptionsControllerView animated:YES completion:nil];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
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

@implementation TabBarOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleHideTabBarLabels:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideTabBarLabels", sender);
}

- (void)toggleHideShortsTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideShortsTab", sender);
}

- (void)toggleHideUploadTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideUploadTab", sender);
}

- (void)toggleHideSubscriptionsTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideSubscriptionsTab", sender);
}

- (void)toggleHideYouTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideYouTab", sender);
}

@end
