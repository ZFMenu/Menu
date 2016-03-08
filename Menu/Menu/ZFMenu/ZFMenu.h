/**
 *  @file
 *  @author 张凡
 *  @date 2016/3/7
 */
#import <UIKit/UIKit.h>

/**
 *  @class ZFMenu
 *  @brief 下拉菜单UI组件
 *  @author 张凡
 *  @date 2016/3/7
 */

@protocol ZFMenuProtocol <NSObject>

- (void)cellClick:(NSInteger)index;

@end

@interface ZFMenu : UIView<UITableViewDataSource,UITableViewDelegate,ZFMenuProtocol>

/// @brief 选项标题集合
@property (strong,nonatomic) NSArray *optionTitles;

/// @brief 设置代理属性
@property (strong,nonatomic) id<ZFMenuProtocol> delegate;

/// @brief 菜单是否已展开(YES为已展开,NO为未展开)
@property (assign,nonatomic) BOOL isSpread;

/// @brief frame为菜单坐标、大小消息；optionTitle为选项内容
- (instancetype)initWithFrame:(CGRect)frame options:(NSArray *)optionTitle;

@end
