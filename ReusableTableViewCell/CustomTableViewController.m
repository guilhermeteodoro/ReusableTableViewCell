#import "CustomTableViewController.h"

@interface CustomTableViewController ()

@end

@implementation CustomTableViewController {
    NSMutableArray *categories;
    NSMutableArray *statics;
}

- (id)init {
    self = [super init];
    
    categories = [[NSMutableArray alloc] initWithArray:[self setContentForArray:@"category" quantity:40]];
    statics = [[NSMutableArray alloc] initWithArray:[self setContentForArray:@"statics" quantity:3]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _lastCellSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"CustomTableView"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        
        case 1:
            return statics.count;
            
        default:
            return categories.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 1 ? 75 : 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomTableView";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            [cell setBackgroundColor:[UIColor redColor]];
            [cell setSearchBar];
            break;
            
        case 1:
            [cell setBackgroundColor:[UIColor yellowColor]];
            cell.textLabel.text = [statics[indexPath.row] objectForKey:@"title"];
            break;
            
        default:
            [cell setBackgroundColor:[UIColor greenColor]];
            cell.textLabel.text = [categories[indexPath.row] objectForKey:@"title"];
            break;
    }
    
    if ([self isLastCellSelected:indexPath]) {
        [cell highlight];
    } else {
        [cell unhighlight];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = (CustomCell *)[tableView cellForRowAtIndexPath:indexPath];
    CustomCell *highlightCell = (CustomCell *)[tableView cellForRowAtIndexPath:_lastCellSelectedIndexPath];

    [highlightCell unhighlight];
    [cell highlight];

    _lastCellSelectedIndexPath = indexPath;
}

#pragma mark - Helpers

- (BOOL)isLastCellSelected:(NSIndexPath *)currentIndexPath {
    return (currentIndexPath.row == _lastCellSelectedIndexPath.row) && (currentIndexPath.section == _lastCellSelectedIndexPath.section);
}

- (NSMutableArray *)setContentForArray:(NSString *)name quantity:(int)quantity{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < quantity; i++) {
        NSString *title = [NSString stringWithFormat:@"%@ %d", name, i + 1];
        NSString *thumb = [NSString stringWithFormat:@"path/to/something/%d", i + 1];
        NSString *event = [NSString stringWithFormat:@"load%@", title];
        
        [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:title, @"title", thumb, @"thumb", event, @"eventToDispatch", nil]];
    }
    
    return array;
}

@end