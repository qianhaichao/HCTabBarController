//
//  RootiewController.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/20.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic,strong) NSDictionary       *dataSource;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataSource[self.dataSource.allKeys[section]] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataSource.allKeys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[self.dataSource.allKeys[indexPath.section]][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.dataSource[self.dataSource.allKeys[indexPath.section]][indexPath.row];
    NSString *class_name = [name stringByAppendingString:@"SimpleViewController"];
    UIViewController *vc = [[NSClassFromString(class_name) alloc] init];
    vc.title = name;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (NSDictionary *)dataSource
{
    if(_dataSource) return _dataSource;
    _dataSource =   @{
                        @"Tool": @[
                                @"UIControl",
                                @"UIWebView"
                                ],
                        @"Category-UIKit": @[
                                @"UIView",
                                ],
                        @"Category-Foundation": @[
                                @"NSString",
                                ]

                        };
    return _dataSource;
}

@end
