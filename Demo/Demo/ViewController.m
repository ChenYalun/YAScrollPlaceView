//
//  ViewController.m
//  Demo
//
//  Created by Chen,Yalun on 2019/8/4.
//  Copyright © 2019 Chen,Yalun. All rights reserved.
//

#import "ViewController.h"
#import "YAScrollPlaceView.h"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray <NSString *> *list;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YAScrollHeaderView *header;
@property (nonatomic, strong) YAScrollFooterView *footer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tableview
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    // 设置头、尾
    self.tableView.scrollHeaderView = self.header;
    self.tableView.scrollFooterView = self.footer;
//    self.header.showAnimationDuration = 0.3f;
//    self.tableView.scrollFooterView = [YAScrollFooterView new];
//    self.tableView.scrollFooterView.height = 100;
//    self.tableView.scrollFooterView.isFixed = YES;
//    [self.header dismissWithCompletion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.header.isVisible) {
            [self.header dismissWithCompletion:nil];
        } else {
            [self.header showWithCompletion:nil];
        }
    } else if (indexPath.row == self.list.count - 1) {
        if (self.footer.isVisible) {
            [self.footer dismissWithCompletion:nil];
        } else {
            [self.footer showWithCompletion:nil];
        }
    }
}

- (UILabel *)descLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    label.text = text;
    label.backgroundColor = UIColor.lightGrayColor;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark - Getter and setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
        _tableView.rowHeight = 70.f;
        _tableView.tableHeaderView = [self descLabelWithText:@"This is tableHeaderView"];
        _tableView.tableFooterView = [self descLabelWithText:@"This is tableFooterView"];
    }
    return _tableView;
}

- (NSArray<NSString *> *)list {
    if (!_list) {
        _list = @[
                  @"点击显示或隐藏header", @"🍎", @"🍎", @"🍎", @"🍎", @"🍎", @"🍎", @"🍎", @"🍎", @"🍎",
                  @"🍎", @"🍎", @"🍎", @"🍎", @"🍎", @"🍎", @"点击显示或隐藏footer"];
    }
    return _list;
}

- (YAScrollHeaderView *)header {
    if (!_header) {
         _header = [YAScrollHeaderView scrollHeaderViewWithSize:CGSizeMake(self.view.bounds.size.width, 200) backgroundImage:[UIImage imageNamed:@"header"]];
    }
    return _header;
}

- (YAScrollFooterView *)footer {
    if (!_footer) {
        _footer = [YAScrollFooterView scrollFooterViewWithSize:CGSizeMake(self.view.bounds.size.width, 200) backgroundImage:[UIImage imageNamed:@"footer"]];
    }
    return _footer;
}
@end
