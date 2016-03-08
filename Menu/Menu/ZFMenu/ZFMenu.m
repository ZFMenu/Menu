#import "ZFMenu.h"
#import "ZFMenuCell.h"

#define ZFMenuCellIdentity @"ZFMenuCell"
@interface ZFMenu ()

/// @brief tableview
@property (strong,nonatomic) UITableView *tableView;
/// @brief frame
@property (assign,nonatomic) CGRect controlFrame;
/// @brief 定时器
@property (strong,nonatomic) NSTimer *timer;

@end

@implementation ZFMenu

- (instancetype)initWithFrame:(CGRect)frame options:(NSArray *)optionTitle
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0)];
    if (self) {
        self.isSpread = NO;
        self.optionTitles = optionTitle;
        self.controlFrame = frame;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self.tableView registerClass:[ZFMenuCell class] forCellReuseIdentifier:ZFMenuCellIdentity];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
        self.hidden = YES;
        //创建定时器，第一个参数，事件间隔；第二个参数为通知对象；第三个参数为调用方法，第五个参数为是否重复通知
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(listAnimation) userInfo:nil repeats:YES];
        //暂停定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        /// @brief 增加kvo观察者，用于观察self.isSpread
        [self addObserver:self forKeyPath:@"self.isSpread" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

#pragma mark - 当kvo观察的值被改变将被调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (self.isSpread) {
        self.hidden = NO;
    }
    //启动定时器
    [self.timer setFireDate:[NSDate distantPast]];
    
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.optionTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZFMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ZFMenuCellIdentity];
    CGRect frame = self.controlFrame;
    frame.size.height = 40;
    frame.origin.x = 0;
    frame.origin.y = 0;
    cell.optionTitle.frame = frame;
    cell.optionTitle.text = self.optionTitles[indexPath.row];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate cellClick:indexPath.row];
}

- (void)cellClick:(NSInteger)index
{
    NSLog(@"--ddd--%ld",index);
}

- (void)dealloc {
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除观察者
    [self removeObserver:self forKeyPath:@"self.isSpread"];
}

#pragma mark - 列表动画,计时器会调用
- (void)listAnimation
{
//    NSLog(@"22222--%ld",self.isSpread);
    CGRect frame = self.frame;
    if (self.isSpread && frame.size.height < self.controlFrame.size.height) {
        frame.size.height += 10;
        self.frame = frame;
        CGRect tableFrame = self.tableView.frame;
        tableFrame.size.height = frame.size.height;
        if (tableFrame.size.height <= self.optionTitles.count * 40.0) {
            self.tableView.frame = tableFrame;
        }
        
        if (frame.size.height >= self.controlFrame.size.height) {
            //暂停定时器
            [self.timer setFireDate:[NSDate distantFuture]];
        }
    }
    else if (self.isSpread == NO && frame.size.height > 0){
        frame.size.height -= 10;
        self.frame = frame;
        CGRect tableFrame = self.tableView.frame;
        tableFrame.size.height = frame.size.height;
        if (tableFrame.size.height >= (CGFloat)0) {
            self.tableView.frame = tableFrame;
        }
        if (frame.size.height <= (CGFloat)0) {
            self.hidden = YES;
            //暂停定时器
            [self.timer setFireDate:[NSDate distantFuture]];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
