//
//  ViewController.m
//  PopMenuView
//
//  Created by 吴德文 on 2019/8/8.
//  Copyright © 2019 Shanutec. All rights reserved.
//

#import "ViewController.h"
#import "PopMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [PopMenuView showPopMenuView:@[@"拍发票",@"看照片",@"拍发票",@"看照片",@"拍发票",@"看照片",@"拍发票",@"看照片"] imgNameArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片",@"拍发票",@"看照片",@"拍发票",@"看照片"] blockTapAction:^(NSInteger index) {
        
        WDWLog(@"index：%ld",index);
    }];
}

@end
