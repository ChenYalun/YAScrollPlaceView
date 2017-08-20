# YAScrollPlaceView

<p align="center">
<a href="http://blog.chenyalun.com"><img src="https://img.shields.io/badge/Language-%20Objective--C%20-blue.svg"></a>
<a href="http://blog.chenyalun.com"><img src="https://img.shields.io/badge/platform-iOS-brightgreen.svg?style=flat"></a>
<a href="http://blog.chenyalun.com"><img src="http://img.shields.io/badge/license-MIT-orange.svg?style=flat"></a>
<a href="http://blog.chenyalun.com"><img src="https://travis-ci.org/ChenYalun/YAScrollPlaceView.svg?branch=master"></a>
</p>

YAScrollHeaderView is a simple header class for UIScrolView.
YAScrollFooterView is a simple footer class for UIScrolView.

In addition, YAScrollHeaderView and YAScrollFooterView are subclasses of YAScrollPlaceView.


## Usage

+ Adding a header view or a footer view to a UIScrollView is straightforward, e.g:

```objective-c

    YAScrollHeaderView *headerView = [YAScrollHeaderView scrollHeaderViewWithSize:CGSizeMake(self.view.bounds.size.width, 100) backgroundImage:[UIImage imageNamed:@"screenshot.png"]];
    headerView.isFixed = YES;
    self.scrollView.scrollHeaderView = headerView;
    self.scrollView.scrollHeaderView.height = 100;
    
    YAScrollFooterView *footerView = [YAScrollFooterView new];
    self.tableView.scrollFooterView = footerView;
    self.tableView.scrollFooterView.canAnimate = NO;
    self.tableView.scrollFooterView.showAnimationDuration = 1.0;
    self.tableView.scrollFooterView.dismissAnimationDuration = 1.0;
```

## Author

[Aaron](http://chenyalun.com)

## License

YAScrollPlaceView is available under the MIT license. See the LICENSE file for more info.


