//
//  MQLProtocolTestController.m
//  MyTestProject
//
//  Created by GT-iOS on 2018/1/24.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//

#import "MQLProtocolTestController.h"
#import "ETL_CheckProtocolView.h"
static NSString *const borrowAgreement = @"《借款协议》";
static NSString *const lenderServiceAgreement = @"《出借人服务协议》";
static NSString *const riskStatement = @"《风险告知书》";
@interface MQLProtocolTestController ()<ETL_CheckProtocolViewDelegate>

@end

@implementation MQLProtocolTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ETL_CheckProtocolView *protocolView = [[ETL_CheckProtocolView alloc]initWithFrame:CGRectMake(0,100, [UIScreen mainScreen].bounds.size.width, 0) string:@"我已经阅读并同意《借款协议》、《出借人服务协议》、《风险告知书》" checkStrings:@[borrowAgreement,lenderServiceAgreement,riskStatement]];
    protocolView.delegate = self;
    [self.view addSubview:protocolView];
}

- (void)didClickProtocolString:(NSString *)str {
    NSLog(@"点击了%@", str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
