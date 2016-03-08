#import "ViewController.h"

@interface ViewController ()

/// @brief 下拉菜单
@property (strong,nonatomic) ZFMenu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// @brief 创建按钮
    UIButton *menuList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    menuList.backgroundColor = [UIColor orangeColor];
    [menuList setTitle:@"菜单" forState:UIControlStateNormal];
    [menuList addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuList];
    
    /// @brief 创建下拉菜单实例
    /// @brief 下拉菜单内容数组
    NSArray *array = @[@"手机",@"电话",@"Email",@"其它"];
    self.menu = [[ZFMenu alloc] initWithFrame:CGRectMake(40, 40, 200, 160) options:array];
    /// @brief 设置代理
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
}

#pragma mark - 当按钮被点击时会被调用
- (void)buttonClick:(id)sender
{
    /// @brief 修改菜单是为隐藏还是显示
    self.menu.isSpread = self.menu.isSpread == YES?NO:YES;
}

#pragma mark - 当菜单选项被点击时会被调用
- (void)cellClick:(NSInteger)index
{
    NSLog(@"%ld被点击",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
