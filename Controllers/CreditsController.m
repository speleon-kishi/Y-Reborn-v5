#import "CreditsController.h"

@interface CreditsController ()

@property (strong, nonatomic) NSArray *credits;
@property (strong, nonatomic) NSArray *roles;
@property (strong, nonatomic) NSArray *urls;

@end

@implementation CreditsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Credits";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"YTSans-Bold" size:22], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.tableView.backgroundColor = [UIColor systemBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    self.credits = @[
        @{@"name": @"Lillie", @"role": @"Original Developer", @"url": @""},
        @{@"name": @"Alpha_Stream", @"role": @"Icon Designer", @"url": @"https://twitter.com/Kutarin_"},
        @{@"name": @"kirb", @"role": @"Development Support", @"url": @"https://github.com/kirb"},
        @{@"name": @"Dayanch96", @"role": @"Features: \"Red Progress Bar\", \"Gray Buffer Progress\" \"Stick Navigation Bar\", \"Disable Double tap to skip\"", @"url": @"https://github.com/Dayanch96"},
        @{@"name": @"PoomSmart", @"role": @"Features: \"YouTube-X/Adblock\", \"AutoPlay In Fullscreen\"", @"url": @"https://twitter.com/PoomSmart"},
        @{@"name": @"Snoolie", @"role": @"Features: \"Enable Extra Video Speed\"", @"url": @"https://github.com/0xilis"}
        @{@"name": @"jkhsjdhjs", @"role": @"Features: \"YouTube Native Share\"", @"url": @"https://github.com/jkhsjdhjs"}
    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.credits.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CreditCell"];
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *credit = self.credits[indexPath.row];
    cell.textLabel.text = credit[@"name"];
    cell.detailTextLabel.text = credit[@"role"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *credit = self.credits[indexPath.row];
    NSURL *url = [NSURL URLWithString:credit[@"url"]];
    if (url) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

@end
