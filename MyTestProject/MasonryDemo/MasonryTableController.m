//
//  MasonryTableController.m
//  MyTestProject
//
//  Created by GT-iOS on 2017/12/4.
//  Copyright © 2017年 GT-iOS. All rights reserved.
//

#import "MasonryTableController.h"
#import "MasonryCell.h"

@interface MasonryTableController ()

@end

@implementation MasonryTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
//    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasonryCell *cell = [MasonryCell masonryCellWithTableView:tableView];
    [cell configCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}








@end
