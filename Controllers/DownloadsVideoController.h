#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>

@interface DownloadsVideoController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UIScrollViewDelegate, AVPlayerViewControllerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *detailTextLabel;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *allItems;
@property (nonatomic, strong) NSArray *filteredItems;
@property (nonatomic, assign) BOOL isSearching;
@end
