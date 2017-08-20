//
//  YAScrollPlaceView.m
//  YAScrollPlaceView <https://github.com/ChenYalun/YAScrollPlaceView>
//
//  Created by 陈亚伦 on 17/8/18.
//  Copyright (c) 2017 Aaron.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "YAScrollPlaceView.h"

static void * const kYAScrollPlaceViewKVOContext = (void*)&kYAScrollPlaceViewKVOContext;
static CGFloat const kAdjustHeight = 70.f;

@implementation YAScrollPlaceView
#pragma mark - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _showAnimationDuration = 0.15f;
        _dismissAnimationDuration = 0.15f;
        _canAnimate = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!self.superview || ![self.superview isKindOfClass:[UIScrollView class]]) return ;
    [self removeObserver];
}

- (void)didMoveToSuperview{
    if (!self.superview || ![self.superview isKindOfClass:[UIScrollView class]]) return ;
    [self.superview addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(contentSize))
                        options:NSKeyValueObservingOptionNew
                        context:kYAScrollPlaceViewKVOContext];
    [self.superview addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(contentOffset))
                        options:NSKeyValueObservingOptionNew
                        context:kYAScrollPlaceViewKVOContext];
    [self show];
    [self adjustScrollViewTopBottom];
}

- (void)removeFromSuperview {
    if (!self.superview || ![self.superview isKindOfClass:[UIScrollView class]]) return ;
    [self dismiss];
    [super removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self refreshScrollViewContentInset];
    [self scrollToTop];
}

#pragma mark - Getter and setter
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    [self refreshScrollViewContentInset];
}

- (BOOL)isVisible {
    return !self.hidden;
}

- (void)setCanAnimate:(BOOL)canAnimate {
    _canAnimate = canAnimate;
    if (!canAnimate) {
        _showAnimationDuration = 0;
        _dismissAnimationDuration = 0;
    } else {
        _showAnimationDuration = 0.15f;
        _dismissAnimationDuration = 0.15f;
    }
}

#pragma mark - Event response
- (void)show {
    [self showWithCompletion:nil];
}

- (void)showWithCompletion:(YAScrollPlaceViewShowCompletion)completion {
    if (self.isVisible) return ;
    [self refreshScrollViewContentInset];
    [self adjustScrollViewTopBottom];
    self.hidden = NO;
    if (completion) { completion(); }
}

- (void)dismiss {
    [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(YAScrollPlaceViewDismissCompletion)completion {
    if (!self.isVisible) return ;
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    UIEdgeInsets inset = scrollView.contentInset;
    if (self->scrollPlaceViewType ==YAScrollPlaceViewTypeHeader) {
        inset.top = 0.f;
    } else {
        inset.bottom = 0.f;
    }
    
    [UIView animateWithDuration:self.canAnimate ? self.dismissAnimationDuration : 0 animations:^(){scrollView.contentInset = inset;} completion:^(BOOL finished) {
        self.hidden = YES;
        if (completion) { completion(); }
    }];
}

- (void)adjustPlaceWithContentOffset:(id)newPoint {
    if (!self.isFixed) return ;
    CGPoint contentOffset = [newPoint CGPointValue];
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    if (self->scrollPlaceViewType == YAScrollPlaceViewTypeHeader) {
        if (contentOffset.y <= -self.height) {
            self.y = contentOffset.y ;
        }
    } else {
        if (contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom - scrollView.contentSize.height >= 0) {
            self.y = scrollView.contentSize.height + contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom - scrollView.contentSize.height;
        }
    }
}

- (void)adjustPlaceWithContentSize:(id)newSize {
    CGSize contentSize = [newSize CGSizeValue];
    if (self->scrollPlaceViewType == YAScrollPlaceViewTypeHeader) {
        self.y = -self.height;
    } else {
        self.y = contentSize.height;
    }
}

- (void)adjustScrollViewTopBottom {
    if (self->scrollPlaceViewType == YAScrollPlaceViewTypeHeader) {
        [self scrollToTop];
    } else {
        [self scrollToBottom];
    }
}

- (void)refreshScrollViewContentInset {
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    UIEdgeInsets inset = scrollView.contentInset;
    if (self->scrollPlaceViewType == YAScrollPlaceViewTypeHeader) {
        inset.top = self.bounds.size.height;
    } else {
        inset.bottom = self.bounds.size.height;
    }
    scrollView.contentInset = inset;
}

- (void)scrollToTop {
    if (!self.superview || ![self.superview isKindOfClass:[UIScrollView class]]) return ;
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    if (scrollView.contentOffset.y  < kAdjustHeight) {
        CGPoint bottomOffset = CGPointMake(0, - scrollView.contentInset.top);
        [UIView animateWithDuration:self.canAnimate ? self.showAnimationDuration : 0 animations:^{
            [scrollView setContentOffset:bottomOffset animated:NO];
        }];
    }
}

- (void)scrollToBottom {
    if (!self.superview || ![self.superview isKindOfClass:[UIScrollView class]]) return ;
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    if (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.bounds.size.height < kAdjustHeight) {
        CGPoint bottomOffset = CGPointMake(0, scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom);
        [UIView animateWithDuration:self.canAnimate ? self.showAnimationDuration : 0 animations:^{
            [scrollView setContentOffset:bottomOffset animated:NO];
        }];
    }
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == kYAScrollPlaceViewKVOContext) {
        if([keyPath isEqualToString:NSStringFromSelector(@selector(contentOffset))]) {
            [self adjustPlaceWithContentOffset:change[NSKeyValueChangeNewKey]];
        }
    
        if([keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))]) {
            [self adjustPlaceWithContentSize:change[NSKeyValueChangeNewKey]];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)removeObserver {
    [self.superview removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize))];
    [self.superview removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
}
@end



@implementation YAScrollHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self->scrollPlaceViewType = YAScrollPlaceViewTypeHeader;
    }
    return self;
}

+ (instancetype)scrollHeaderViewWithSize:(CGSize)size backgroundImage:(UIImage *)image {
    YAScrollHeaderView *view = [[YAScrollHeaderView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = view.bounds;
    [view addSubview:imageView];
    return view;
}
@end



@implementation YAScrollFooterView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self->scrollPlaceViewType = YAScrollPlaceViewTypeFooter;
    }
    return self;
}

+ (instancetype)scrollFooterViewWithSize:(CGSize)size backgroundImage:(UIImage *)image {
    YAScrollFooterView *view = [[YAScrollFooterView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = view.bounds;
    [view addSubview:imageView];
    return view;
}
@end
