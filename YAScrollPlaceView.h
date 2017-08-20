//
//  YAScrollPlaceView.h
//  YAScrollPlaceView <https://github.com/ChenYalun/YAScrollPlaceView>
//
//  Created by 陈亚伦 on 17/8/18.
//  Copyright (c) 2017 Aaron.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^YAScrollPlaceViewShowCompletion)(void);
typedef void (^YAScrollPlaceViewDismissCompletion)(void);

typedef NS_ENUM(NSUInteger, YAScrollPlaceViewType){
    YAScrollPlaceViewTypeHeader,
    YAScrollPlaceViewTypeFooter
};

/**
 The YAScrollPlaceView class represents a header or a footer for UIScrollView.
 */
@interface YAScrollPlaceView : UIView
{
    YAScrollPlaceViewType scrollPlaceViewType;
}

@property (nonatomic, assign) BOOL isFixed; ///< default NO.Fix the place view to the top or bottom.
@property (nonatomic, assign) BOOL canAnimate; ///< default YES.
@property (nonatomic, assign) CGFloat height; ///< default 0
@property (nonatomic, assign, readonly) BOOL isVisible;; ///< default NO.
@property (nonatomic, assign) NSTimeInterval showAnimationDuration;    ///< default 0.15
@property (nonatomic, assign) NSTimeInterval dismissAnimationDuration;   ///< default 0.15
- (void)show;
- (void)dismiss;
- (void)showWithCompletion:(YAScrollPlaceViewShowCompletion)completion;
- (void)dismissWithCompletion:(YAScrollPlaceViewDismissCompletion)completion;
@end


/**
 Use this subclass to easily set up the header of a scroll view.
 */
@interface YAScrollHeaderView : YAScrollPlaceView

/**
 Set a picture for header view.

 @param size  Size of picture.
 @param image  The picture on the header view.
 @return A new instance, or nil if an error occurs.
 */
+ (instancetype)scrollHeaderViewWithSize:(CGSize)size backgroundImage:(UIImage *)image;
@end



/**
 Use this subclass to easily set up the footer of a scroll view.
 */
@interface YAScrollFooterView : YAScrollPlaceView

/**
 Set a picture for footer view.
 
 @param size  Size of picture.
 @param image  The picture on the footer view.
 @return A new instance, or nil if an error occurs.
 */
+ (instancetype)scrollFooterViewWithSize:(CGSize)size backgroundImage:(UIImage *)image;
@end



/**
 Set association properties.
 */
@interface UIScrollView (YAScrollPlaceView)
@property  YAScrollHeaderView *scrollHeaderView;
@property  YAScrollFooterView *scrollFooterView;
@end
@implementation UIScrollView (YAScrollPlaceView)
@dynamic scrollHeaderView;
@dynamic scrollFooterView;

- (YAScrollHeaderView *)scrollHeaderView {
    return objc_getAssociatedObject(self, @selector(scrollHeaderView));
}

- (void)setScrollHeaderView:(YAScrollHeaderView *)scrollHeaderView {
    if (scrollHeaderView == self.scrollHeaderView) return ;
    [self.scrollHeaderView removeFromSuperview];
    [self addSubview:scrollHeaderView];
    objc_setAssociatedObject(self, @selector(scrollHeaderView), scrollHeaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YAScrollFooterView *)scrollFooterView {
    return objc_getAssociatedObject(self, @selector(scrollFooterView));
}

- (void)setScrollFooterView:(YAScrollFooterView *)scrollFooterView {
    if (scrollFooterView == self.scrollFooterView) return ;
    [self.scrollFooterView removeFromSuperview];
    [self addSubview:scrollFooterView];
    objc_setAssociatedObject(self, @selector(scrollFooterView), scrollFooterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end



/**
 Set the frame of the view.
 */
@interface UIView (YAExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@end
@implementation UIView (YAExtension)
- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
@end
