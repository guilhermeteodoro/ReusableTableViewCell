#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *highlightBar;

- (void)setSearchBar;
- (void)highlight;
- (void)unhighlight;

@end
