//
//  LockViewController.m
//  MyTestProject
//
//  Created by GT-iOS on 2018/3/27.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//

#import "LockViewController.h"
#import <objc/runtime.h>
#import <pthread.h>
static char *checkUserStringKey = "checkUserStringKey";
@interface LockViewController ()
@property (nonatomic, strong) NSString *number;
@end

//@dynamic checkUserString;

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"%d=====%@", i, [NSThread currentThread]);
            self.checkUserString = [NSString stringWithFormat:@"%d", i];
            
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 20; i < 100; i++) {
            NSLog(@"%d=====%@", i, [NSThread currentThread]);
            self.checkUserString = [NSString stringWithFormat:@"%d", i];
        }
    });
    
}

- (void)setCheckUserString:(NSString *)checkUserString {
    static pthread_mutex_t pLock;
    pthread_mutex_init(&pLock, NULL);
    pthread_mutex_lock(&pLock);
    objc_setAssociatedObject(self, &checkUserStringKey, checkUserString, OBJC_ASSOCIATION_COPY_NONATOMIC);
    pthread_mutex_unlock(&pLock);
}
//- (NSString *)checkUserString {
//    return (NSString *)objc_getAssociatedObject(self, &checkUserStringKey);
//}

//- (void)setNumber:(NSString *)number {
//    _number = number;
//}

//- (void)setNumber:(NSInteger)number {
//    _number = number;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
