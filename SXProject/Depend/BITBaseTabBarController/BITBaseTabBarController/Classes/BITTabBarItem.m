//
//  BITTabBarItem.m
//  Pods
//
//  Created        huihui on 2017/11/16.
//
//

#import "BITTabBarItem.h"
#import "UIView+BitInfo.h"
#define TABBAR_ITEM_SPAN_TOP    6.0
#define TABBAR_ITEM_SPAN_BOTTOM 3

@interface BITTabBarItem ()

@property (nonatomic, strong) UIImage        *icon;
@property (nonatomic, strong) UIImage        *selectedIcon;
//@property (nonatomic, strong) UILabel        *label;
//@property (nonatomic, strong) UIImageView    *imageView;
@property (nonatomic, strong) UIColor       *titleColor;
@property (nonatomic, strong) UIColor       *selectedTitleColor;
@property (nonatomic, strong) UIView        *backgroundView;
@property (nonatomic, assign) BOOL          extendedIcon;

@end

@implementation BITTabBarItem


- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor icon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon
{
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    if (self) {
        self.selected = NO;
        
        self.icon = icon;
        self.selectedIcon = selectedIcon;
        self.titleColor = titleColor;
        self.selectedTitleColor = selectedTitleColor;
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 12)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = self.titleColor;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.userInteractionEnabled = NO;
        self.label.text = title;
        self.label.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.label];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - icon.size.width) / 2, 6, 24, 24)];
        
        self.imageView.image = self.icon;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        [self addTarget:self action:@selector(didSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.width = self.width;
    self.imageView.top = TABBAR_ITEM_SPAN_TOP;
    self.label.width = self.width;
    self.label.top = 24 + TABBAR_ITEM_SPAN_TOP + 3.f;
    
    
    [self updateImageViewFrame];
    
//
//    self.badgeView.center = CGPointMake(self.imageView.right + 1, self.imageView.top + 5);
}

- (void)setExtendedIcon:(BOOL)extendedIcon
{
    if (_extendedIcon != extendedIcon) {
        _extendedIcon = extendedIcon;
    }
}

//- (void)setBadgeView:(UXBadgeView *)badgeView
//{
//    if (_badgeView) {
//        [_badgeView removeFromSuperview];
//    }
//    _badgeView = badgeView;
//    [self addSubview:_badgeView];
//}

-(void)setTitle:(NSString*)title
{
    self.label.text = title;
}

- (NSString *)title{
    return self.label.text;
}

- (void)setIcon:(UIImage *)image
{
    [self setIcon:image enableExtend:NO];
}

- (void)setIcon:(UIImage *)image enableExtend:(BOOL)isExtended
{
    if (!image) {
        return;
    }
    
    _icon = image;
    if (_extendedIcon != isExtended) {
        _extendedIcon = isExtended;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    
    if (!self.selected) {
        self.imageView.image = image;
    }
}

- (void)setSelectedIcon:(UIImage *)selectedIcon enableExtend:(BOOL)isExtended
{
    _selectedIcon = selectedIcon;
    
    if (_extendedIcon != isExtended) {
        _extendedIcon = isExtended;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    
    if (self.selected) {
        self.imageView.image = selectedIcon;
    }
}

- (void)updateImageViewFrame
{
    if (self.extendedIcon) {
        UIImage *image = self.selected ? self.selectedIcon : self.icon;
        if (image) {
            [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 24, [self heightForExtendedIcon:image.size])];
        }
    }else {
        [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 24, 24)];
    }
    self.imageView.top = TABBAR_ITEM_SPAN_TOP;
    
    self.imageView.centerX = self.width / 2;
    self.imageView.frame = CGRectOffset(self.imageView.frame, self.imageInset.left, self.imageInset.top);
}

- (CGFloat)heightForExtendedIcon:(CGSize)size
{
    CGFloat ratio = 1.0 * size.width / size.height;
    return ceil(24.0 / ratio);
}

- (void)setSelectedIcon:(UIImage *)selectedIcon
{
    [self setSelectedIcon:selectedIcon enableExtend:NO];
}

-(void)setSelectedTextColor:(UIColor *) selectedTitleColor
{
    if (!selectedTitleColor) {
        return;
    }
    
    _selectedTitleColor = selectedTitleColor;
    
    if (self.selected) {
        self.label.textColor = self.selectedTitleColor;
    }
}

#pragma -mark
#pragma -mark action

- (void)didSelect
{
    if ([self.delegate respondsToSelector:@selector(tabBarItemdidSelected:)]) {
        [self.delegate tabBarItemdidSelected:self];
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected == self.selected) {
        return;
    }
    
    super.selected = selected;
    
    if (!selected) {
        self.imageView.image = self.icon;
        self.label.textColor = self.titleColor;
    } else {
        self.imageView.image = self.selectedIcon;
        self.label.textColor = self.selectedTitleColor;
    }
}

- (void)setTextColor:(UIColor*)textColor{
    if (!textColor) {
        return;
    }
    _titleColor = textColor;
    if (!self.selected) {
        self.label.textColor = self.titleColor;
    }
}

- (void)resetItemWithTitle:(NSString *)title
                     color:(UIColor *)color
             selectedColor:(UIColor *)selectedColor
                      icon:(UIImage *)icon
              selectedIcon:(UIImage *)selectedIcon{
    self.title = title;
    self.icon = icon;
    self.selectedIcon = selectedIcon;
    self.selectedTitleColor = selectedColor;
    self.titleColor = color;
    
    self.label.text = title;
    
    if (self.selected) {
        self.label.textColor = selectedColor;
        self.imageView.image = selectedIcon;
    }
    else{
        self.label.textColor = color;
        self.imageView.image = icon;
    }
}


@end
