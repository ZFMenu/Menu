#import "ZFMenuCell.h"

@implementation ZFMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize size = self.frame.size;
        /// @brief 选项标题标签
        self.optionTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 40)];
        self.optionTitle.textColor = [UIColor blackColor];
        self.optionTitle.backgroundColor = [UIColor grayColor];
        self.optionTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.optionTitle];
    }
    
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
