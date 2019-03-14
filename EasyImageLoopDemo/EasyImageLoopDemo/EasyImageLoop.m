//
//  EasyImageLoop.m
//  EasyImageLoopDemo
//
//  Created by Sen on 2019/3/14.
//  Copyright © 2019年 Sen. All rights reserved.
//

#import "EasyImageLoop.h"

@interface EasyImageLoop ()
<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* rootView;
@property (nonatomic, strong) UIImageView* imgvLeft;
@property (nonatomic, strong) UIImageView* imgvCenter;
@property (nonatomic, strong) UIImageView* imgvRight;

@end

@implementation EasyImageLoop
{
    NSInteger currIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.rootView];
        [_rootView addSubview:self.imgvLeft];
        [_rootView addSubview:self.imgvCenter];
        [_rootView addSubview:self.imgvRight];
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    if (!items || items.count < 3) {
        return;
    }
    _items = items;
    
    //img defaule set
    _imgvLeft.image = _items[_items.count-1];
    _imgvCenter.image = _items[0];
    _imgvRight.image = _items[1];
    
    currIndex = 0;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger tmpIndex = scrollView.contentOffset.x / self.bounds.size.width;
    
    if (tmpIndex == 0)
    {
        // 图片从左边往右边翻动，手势是向右滑动
        if (currIndex == 0) {
            currIndex = _items.count-1;
        }else{
            currIndex--;
        }
    }else if (tmpIndex == 2)
    {
        // 图片从右向左边翻动，手势是向左滑动
        if (currIndex == _items.count-1) {
            currIndex = 0;
        }else{
            currIndex++;
        }
    }
    NSLog(@"currIndex %ld",currIndex);
    _imgvLeft.image = [self getImageLeftAtIndex:currIndex];
    _imgvCenter.image = [self getImageCenterAtIndex:currIndex];
    _imgvRight.image = [self getImageRightAtIndex:currIndex];
    
    scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    
}

- (UIImage*)getImageLeftAtIndex:(NSInteger)index
{
    if (index == 0) {
        return _items.lastObject;
    }else{
        return _items[index-1];
    }
}
- (UIImage*)getImageCenterAtIndex:(NSInteger)index
{
    if (index < 0 || index >= _items.count) {
        return nil;
    }else {
        return _items[index];
    }
}
- (UIImage*)getImageRightAtIndex:(NSInteger)index
{
    if (index == (_items.count-1)) {
        return _items.firstObject;
    }else{
        return _items[index+1];
    }
}

#pragma mark - lazy

- (UIScrollView *)rootView
{
    if (!_rootView) {
        _rootView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _rootView.contentSize = CGSizeMake(self.bounds.size.width*3, self.bounds.size.height);
        _rootView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _rootView.pagingEnabled = YES;
        _rootView.showsHorizontalScrollIndicator = NO;
        _rootView.delegate = self;
    }
    return _rootView;
}
- (UIImageView *)imgvLeft
{
    if (!_imgvLeft) {
        _imgvLeft = [[UIImageView alloc] initWithFrame:[self imagevFrameWithIndex:0]];
        [self imagevConfiguration:_imgvLeft];
    }
    return _imgvLeft;
}
- (UIImageView *)imgvCenter
{
    if (!_imgvCenter) {
        _imgvCenter = [[UIImageView alloc] initWithFrame:[self imagevFrameWithIndex:1]];
        [self imagevConfiguration:_imgvCenter];
    }
    return _imgvCenter;
}
- (UIImageView *)imgvRight
{
    if (!_imgvRight) {
        _imgvRight = [[UIImageView alloc] initWithFrame:[self imagevFrameWithIndex:2]];
        [self imagevConfiguration:_imgvRight];
    }
    return _imgvRight;
}

- (CGRect)imagevFrameWithIndex:(NSInteger)index
{
    return CGRectMake(index*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
}
- (void)imagevConfiguration:(UIImageView *)imgx
{
    imgx.userInteractionEnabled = YES;
    imgx.contentMode = UIViewContentModeScaleAspectFill;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
