//
//  ViewController.m
//  MyTestProject
//
//  Created by GT-iOS on 2017/12/4.
//  Copyright © 2017年 GT-iOS. All rights reserved.
//

#import "ViewController.h"

static NSString *const demoTitle = @"demoTitle";
static NSString *const desController = @"desController";
static NSString *const cellId = @"cellId";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    NSDictionary *demo1 = @{demoTitle: @"Cell高度自适应(masonry)", desController: @"MasonryTableController"};
    NSDictionary *demo2 = @{demoTitle: @"AVAudioPlayer播放本地视频流", desController: @"AVAudioController"};
    NSDictionary *demo3 = @{demoTitle: @"maskLayer", desController: @"MaskLayerController"};
    NSDictionary *demo4 = @{demoTitle: @"UITextView去除padding", desController: @"TextViewDemoController"};
    NSDictionary *demo5 = @{demoTitle: @"图文混排", desController: @"QLTestController"};
     NSDictionary *demo6 = @{demoTitle: @"富文本之勾选协议", desController: @"MQLProtocolTestController"};
    NSDictionary *demo7 = @{demoTitle: @"AFN源码学习", desController: @"AFNLearnController"};
    NSDictionary *demo8 = @{demoTitle: @"iOS中的锁", desController: @"LockViewController"};
    NSDictionary *demo9 = @{demoTitle: @"iOS11导航条item偏移", desController: @"TestNavigationBar"};
    
    [self.dataArray addObject:demo1];
    [self.dataArray addObject:demo2];
    [self.dataArray addObject:demo3];
    [self.dataArray addObject:demo4];
    [self.dataArray addObject:demo5];
    [self.dataArray addObject:demo6];
    [self.dataArray addObject:demo7];
    [self.dataArray addObject:demo8];
    [self.dataArray addObject:demo9];
    [self.view addSubview:self.tableView];
    
//    YYFPSLabel *la = [[YYFPSLabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 25, 60, 40)];
//    [[UIApplication sharedApplication].keyWindow addSubview:la];
    NSString *first = @"12974086.9456";
    NSString *second = @"12";
    NSString *pro = [self handleDecimal:first :second];
    NSLog(@"%.2f", [pro doubleValue]);
    NSLog(@"%.2f", [self handleOnlyDecimal:first].doubleValue);
    
    UILabel *l = [UILabel new];
    l.text = @"中华人民共和国";
    l.font = [UIFont systemFontOfSize:30];
    CGFloat h = l.font.pointSize;
    NSLog(@"%.2f", h);
}

- (NSString *)handleDecimal:(NSString *)firstDeci :(NSString *)secondDeci {
    NSDecimalNumber *firstNumber = [NSDecimalNumber decimalNumberWithString:firstDeci];
    NSDecimalNumber *secondNumber = [NSDecimalNumber decimalNumberWithString:secondDeci];
    NSDecimalNumber *product = [firstNumber decimalNumberByAdding:secondNumber];
    return [product stringValue];
}

- (NSString * )handleOnlyDecimal:(NSString *)deci {
    NSDecimalNumber *onli = [NSDecimalNumber decimalNumberWithString:deci];
    NSDecimalNumber *d1 = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumberHandler *handle = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber* result = [onli decimalNumberByMultiplyingBy:d1 withBehavior:handle];
    return [result stringValue];
}

- (void)handleString {
    NSString *str = @"12行";
    
    NSRange ra = [str rangeOfString:@"万"];
    NSLog(@"%@", NSStringFromRange(ra));
    NSLog(@"%@", [str substringToIndex:(ra.location+1)]);
    
}

// MARK: - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:demoTitle];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    NSString *desClassName = [dict objectForKey:desController];
    Class cls = NSClassFromString(desClassName);
    UIViewController *vc = [[cls alloc]init];
    vc.title = [dict objectForKey:demoTitle];
    [self.navigationController pushViewController:vc animated:NO];
}

// MARK: - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
