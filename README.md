# YAScrollPlaceView

<p align="center">
<a href="http://blog.chenyalun.com"><img src="https://img.shields.io/badge/Language-%20Objective--C%20-blue.svg"></a>
<a href="http://blog.chenyalun.com"><img src="https://img.shields.io/badge/platform-iOS-brightgreen.svg?style=flat"></a>
<a href="http://blog.chenyalun.com"><img src="http://img.shields.io/badge/license-MIT-orange.svg?style=flat"></a>
<a href="http://blog.chenyalun.com"><img src="https://travis-ci.org/ChenYalun/YAScrollPlaceView.svg?branch=master"></a>
</p>

YAScrollHeaderView and YAScrollFooterView are subclasses of YAScrollPlaceView.


## Usage

+ Adding a header view or a footer view to a UIScrollView is straightforward, e.g:

#### Add an image view

```objective-c
    // Add a picture to the scrollView as a placeholder.
    UIImage *headerImage = [UIImage imageNamed:@"header"];
    YAScrollHeaderView *headerView = [YAScrollHeaderView scrollHeaderViewWithSize:CGSizeMake(self.view.bounds.size.width, 100) backgroundImage:headerImage];
    self.scrollView.scrollHeaderView = headerView;
```

#### Add a blank placeholder

```objective-c
    // Add a fixed blank placeholder to the tableView.
    YAScrollFooterView *footerView = [YAScrollFooterView new];
    footerView.height = 100;
    footerView.isFixed = YES;
    self.tableView.scrollFooterView = footerView; 
```

#### Display or hide dynamically

```objective-c
    // Display or hide the place view dynamically.
    self.tableView.scrollHeaderView = self.header;
    self.header.showAnimationDuration = 0.8f;
    self.header.dismissAnimationDuration = 0.8f;
    [self.header show];
    // [self.header dismissWithCompletion:nil];
```
## Demo
![](/Resource/demo.gif)

## Article

[开源项目：YAScrollPlaceView](https://blog.chenyalun.com/2017/10/01/开源项目：YAScrollPlaceView/)

## Author
[Yalun, Chen](http://chenyalun.com)

## License

YAScrollPlaceView is available under the MIT license. See the LICENSE file for more info.


