//
//  BITTabBar.m
//  Pods
//
//  Created        huihui on 2017/11/16.
//
//

#import "BITTabBar.h"
#import "UIView+BitInfo.h"

@interface BITTabBar ()

@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,assign) NSUInteger selectedIndex;
@property(nonatomic,strong) UIView *barPanel;
@property(nonatomic,strong) UIImageView *barPanelBackGroundView;
@property(nonatomic,strong) UIImage *barPanelBackGroundImage;

@end

@implementation BITTabBar

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<BITTabBarDelegate>)delegate
{
    self = [self initWithFrame:frame items:items delegate:delegate selectedIndex:0];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<BITTabBarDelegate>)delegate selectedIndex:(NSUInteger)selectedIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedIndex = selectedIndex;
        self.delegate = delegate;
        self.items = [items copy];
        [self shareInit];
    }
    return self;
}

- (void)shareInit
{
    /// bar panel
    self.barPanel = [[UIView alloc]initWithFrame:self.bounds];
    self.barPanel.backgroundColor = [UIColor clearColor];
    self.barPanel.userInteractionEnabled = YES;
    [self addSubview:self.barPanel];
    
    [self addItems];
    [self effectRefresh];
}

- (void)setBlurNeedOpen:(BOOL)blurNeedOpen
{
    _blurNeedOpen = blurNeedOpen;
    [self effectRefresh];
}

- (void)effectRefresh
{
    if (self.barPanelBackGroundView) {
        [self.barPanelBackGroundView removeFromSuperview];
        self.barPanelBackGroundView = nil;
    }
    
    if (_blurNeedOpen&&!self.barPanelBackGroundImage) {
        if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
            UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = self.bounds;
            effectView.tintColor = [UIColor whiteColor];
            self.barPanelBackGroundView = effectView;
            [self insertSubview:self.barPanelBackGroundView belowSubview:self.barPanel];
            return;
        }
    }
    
    self.barPanelBackGroundView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.barPanelBackGroundView.contentMode = UIViewContentModeScaleToFill;
    self.barPanelBackGroundView.backgroundColor = [UIColor whiteColor];
    self.barPanelBackGroundView.image = self.barPanelBackGroundImage;
    [self insertSubview:self.barPanelBackGroundView belowSubview:self.barPanel];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.barPanelBackGroundImage = backgroundImage;
    [self effectRefresh];
}

- (void)selectItemAtIndex:(NSInteger)index
{
    if (index < self.items.count) {
        [self tabBarItemdidSelected:self.items[index]];
    }
}

- (void)setBadge:(NSInteger)badge atIndex:(NSInteger)index
{
//    BITTabBarItem *item = self.items[index];
}

#pragma -mark
#pragma -mark reload data

- (void)addItems
{
    NSUInteger barNum = self.items.count;
    
    CGFloat width = (self.width) / barNum;
    CGFloat xOffset = 0.0f;
    
    for (int i = 0; i < barNum; i++) {
        BITTabBarItem *item = self.items[i];
        item.width = width;
        item.height = self.height;
        item.left = xOffset;
        item.delegate = self;
        if (i == self.selectedIndex) {
            item.selected = YES;
        }
        item.tag = -i;
        xOffset += width;
        
        [self.barPanel addSubview:item];
    }
}

#pragma -mark tabbar item delegate
- (void)tabBarItemdidSelected:(BITTabBarItem *)item{
    
    NSUInteger index = -item.tag;
    
    if (index >= [self.items count]) {
        return;
    }
    
    if (self.selectedIndex != index) {
        
        BOOL shouldSelect = YES;
        if ([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]) {
            shouldSelect = [self.delegate tabBar:self shouldSelectItemAtIndex:index];
        }
        
        if (!shouldSelect) {
            return;
        }
        
        BITTabBarItem* old = [self.items objectAtIndex:self.selectedIndex];
        if (old) {
            old.selected = NO;
        }
    }
    
    self.selectedIndex = index;
    item.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectItemAtIndex:index];
    }
}


@end
