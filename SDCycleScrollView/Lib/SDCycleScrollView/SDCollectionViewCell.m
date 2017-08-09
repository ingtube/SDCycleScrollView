//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * 🌟🌟🌟 新建SDCycleScrollView交流QQ群：185534916 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * 新浪微博:GSD_iOS
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios
 *
 * 另（我的自动布局库SDAutoLayout）：
 *  一行代码搞定自动布局！支持Cell和Tableview高度自适应，Label和ScrollView内容自适应，致力于
 *  做最简单易用的AutoLayout库。
 * 视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * 用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 * GitHub：https://github.com/gsdios/SDAutoLayout
 *********************************************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
    __weak UILabel *_commentLabel;
    __weak UIButton *_closeButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
        [self setupAvatarView];
        [self setupCommentLabel];
        [self setupCloseButton];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
}

- (void)setupCommentLabel
{
    UILabel *lbl = [[UILabel alloc] init];
    lbl.numberOfLines = 2.;
    lbl.textColor = [UIColor blackColor];
    lbl.font = [UIFont systemFontOfSize:13. weight:UIFontWeightMedium];

    _commentLabel = lbl;
    _commentLabel.hidden = YES;
    [self.contentView addSubview:_commentLabel];
}

- (void)setupCloseButton
{
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"banner_shutdown"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(didClickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _closeButton = closeBtn;
    _closeButton.hidden = YES;
    [self addSubview:closeBtn];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
}

- (void)setComment:(NSString *)comment {
    _comment = comment;
    _commentLabel.text = _comment;
    if (_commentLabel.hidden) {
        _commentLabel.hidden = NO;
    }
}

- (void)setupAvatarView {
    UIImageView *av = [[UIImageView alloc] init];
    av.layer.cornerRadius = 18.f;
    av.layer.masksToBounds = YES;
    _AvatarImageView = av;
    [self.contentView addSubview:av];
}

- (void)setShowCloseButton:(BOOL)showCloseButton {
    _showCloseButton = showCloseButton;
    _closeButton.hidden = !showCloseButton;
}

- (void)didClickCloseButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(collectionCellDidClickClose:)]) {
        [self.delegate collectionCellDidClickClose:self.bannerId];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat titleLabelW = self.sd_width;
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.sd_height - titleLabelH;
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
        _commentLabel.frame = CGRectMake(62, 13, [UIScreen mainScreen].bounds.size.width - 48. - 74., 36);
        _AvatarImageView.frame = CGRectMake(16, 14, 36, 36);
        _closeButton.frame = CGRectMake(self.bounds.size.width - 36, 0, 36, 36);
    }
}

@end
