#import "PictureInPictureOptionsController.h"

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

@interface PictureInPictureOptionsController ()
- (void)coloursView;
@end

@implementation PictureInPictureOptionsController

- (void)loadView {
    [super loadView];
    [self coloursView];

    self.title = @"Picture In Picture Options";

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneButton;

    [self.tableView setSectionHeaderTopPadding:0.0f];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PictureInPictureTableViewCell"];

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
            cell.textLabel.text = @"Enable Picture In Picture";
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kRebornIHaveYouTubePremium"] == YES) {
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
            } else {
                CREATE_SWITCH(enablePictureInPicture, toggleEnablePictureInPicture, @"kEnablePictureInPictureVTwo");
            }
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"Hide PIP Ads Badge";
            CREATE_SWITCH(hidePictureInPictureAdsBadge, toggleHidePictureInPictureAdsBadge, @"kHidePictureInPictureAdsBadge");
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"Hide PIP Sponsor Badge";
            CREATE_SWITCH(hidePictureInPictureSponsorBadge, toggleHidePictureInPictureSponsorBadge, @"kHidePictureInPictureSponsorBadge");
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIAlertController *alertError = [UIAlertController alertControllerWithTitle:@"Notice" message:@"This feature has been disabled cause you have the 'I Have YouTube Premium' option enabled" preferredStyle:UIAlertControllerStyleAlert];

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

@implementation PictureInPictureOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleEnablePictureInPicture:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnablePictureInPictureVTwo", sender);
}

- (void)toggleHidePictureInPictureAdsBadge:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHidePictureInPictureAdsBadge", sender);
}

- (void)toggleHidePictureInPictureSponsorBadge:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHidePictureInPictureSponsorBadge", sender);
}

@end
