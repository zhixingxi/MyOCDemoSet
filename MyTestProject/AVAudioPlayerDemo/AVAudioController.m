//
//  AVAudioController.m
//  MyTestProject
//
//  Created by GT-iOS on 2017/12/13.
//  Copyright © 2017年 GT-iOS. All rights reserved.
//

#import "AVAudioController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVAudioController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlay;
@end

@implementation AVAudioController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self startPlay];
}


- (void)startPlay {
    NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"abc" ofType:@"aac"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    //初始化播放器对象
    self.audioPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
    //设置声音的大小
    self.audioPlay.volume = 0.5;//范围为（0到1）；
    //设置循环次数，如果为负数，就是无限循环
    self.audioPlay.numberOfLoops =-1;
    //设置播放进度
    self.audioPlay.currentTime = 0;
    //准备播放
    [self.audioPlay prepareToPlay];
    [self.audioPlay play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
