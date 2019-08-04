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




/**
 Set the frame of the view.
 */
@interface UIView (YAExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@end

