#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Just to override the default;
}

- (void)setSearchBar {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview: _searchBar];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_searchBar removeFromSuperview];
}

- (void)highlight {
    self.textLabel.textColor = [UIColor blueColor];
    
    _highlightBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, self.bounds.size.height)];
    [_highlightBar setBackgroundColor:[UIColor blueColor]];
    
    [self addSubview:_highlightBar];
}

- (void)unhighlight {
    self.textLabel.textColor = [UIColor blackColor];
    [_highlightBar removeFromSuperview];
}

@end
